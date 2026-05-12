To use LAMMPS on Young, first make an apptainer. Use [this](lammps_apptainer_Young.def) file to create the apptainer.
Then run (requires `sudo` access): 
```
apptainer build --fakeroot mace-lammps-young.sif mace-lammps-young-sge.def
``` 
It takes about ~20 mins to run this. Then transfer the `.sif` file to Young. 
Use [this script](lammps_multi_gpu_Young_submit.sh) to submit your multi-GPU Job!
