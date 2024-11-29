read   rand1 rand2 < tmp_random
echo   variable T  equal 5.0

echo   units            lj
echo   boundary         s s s  
echo   atom_style       angle
echo   log              log.polymer.txt
echo   read_data        polymer0.txt


#echo   region 6wall block  8 90 8 90 8 85
#echo   fix w1  all wall/region 6wall lj126 1 1 2.5


echo  mass   \*  1

echo  group mc  type 2 3
echo  group AAm type 1 

echo  bond_style   harmonic
echo  bond_coeff   1 100 0.1
echo  bond_coeff   2   1 1.0

echo  angle_style     harmonic
echo  angle_coeff     1 100.0  180.0  

echo  special_bonds   lj 0.0 0.0 0.0
echo  pair_style   soft  1.0
echo  pair_coeff   \* \* 0.0  0.1
echo  pair_coeff   2  2  10.0 0.5 


echo  neighbor 0.3 bin
echo  neigh_modify every 1 delay 10 check yes
echo  comm_modify mode single cutoff 3.0

echo  velocity  all  create \${T}  ${rand1}   # 1 is temperature, seed for random
echo  fix  1 all nve/limit 0.05 # 0.05 is max distance an atom can move in a timestep
echo  fix  2 all langevin \${T}  \${T}  1.0 ${rand1}

#echo  minimize 0.01 0.001 10000 100000
echo timestep 0.01

echo  reset_timestep 0
echo  thermo_style custom step temp  bonds
echo  thermo 10000
#echo  dump 1 all custom   10000 full.lammpstrj id c_imol type x y z
echo  dump 2 all custom   10000 jieguo1.lammpstrj id mol type  x y z #vmd_jieguo图
#echo  dump_modify 1 sort id
echo  dump_modify 2 sort id
echo  run 30000
echo  write_data 1.data

