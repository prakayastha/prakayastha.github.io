#!/bin/bash -l
#SBATCH --job-name=Pingu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=20G
#SBATCH --time=01:00:00
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

cd "$SLURM_SUBMIT_DIR"

SIF=/home/mmm1350/Scratch/mace-lammps-young.sif

apptainer exec --cleanenv --nv "$SIF" lmp_sge -np 1 -in in.lammps > out
