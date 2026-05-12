#!/bin/bash -l
#$ -S /bin/bash
#$ -N lammps_mace_md
#$ -cwd
#$ -j y
#$ -o .
#$ -l h_rt=2:00:0
#$ -l gpu=4
#$ -pe ppn=4 4
#$ -l mem=8G
#$ -l tmpfs=50G
#$ -P Free
#$ -A UCL_chemM_Butler
##$ -ac exclusive

set -euo pipefail

module purge 2>/dev/null || true
module load apptainer

# Override these at submit time if you want, e.g.
#   qsub -v IMAGE=/path/to/mace-lammps-young.sif,INPUT=in.md young-sge-multigpu-md.sh
IMAGE="mace-lammps-young-sge.sif"
INPUT="in.batio3_mace"

# For multi-GPU MD we usually want one MPI rank per GPU.
export OMP_NUM_THREADS=1

export APPTAINERENV_OMP_NUM_THREADS=1
export APPTAINERENV_PYTHONNOUSERSITE=1
export APPTAINERENV_PYTHONPATH="/usr/local/lib/python3.10/dist-packages:/usr/lib/python3/dist-packages"

export APPTAINERENV_OMPI_MCA_pml=ucx
export APPTAINERENV_OMPI_MCA_osc=ucx
export APPTAINERENV_OMPI_MCA_btl="^openib,smcuda"

export APPTAINER_BINDPATH="${PWD}"
if [[ -n "${TMPDIR:-}" ]]; then
  export APPTAINER_BINDPATH="${APPTAINER_BINDPATH},${TMPDIR}"
fi

CONTAINER_HOME="${TMPDIR:-$PWD}/container-home"
mkdir -p "${CONTAINER_HOME}"

apptainer exec --cleanenv --nv \
  --home "${CONTAINER_HOME}:${HOME}" \
  "${IMAGE}" \
  lmp_sge -np "${NSLOTS}" -in "${INPUT}"
