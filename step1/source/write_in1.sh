read   rand1 rand2 < tmp_random
echo   variable T  equal 0.8

echo   units            lj
echo   boundary         s s s
echo   atom_style       angle
echo   log              log.polymer.txt
echo   read_data        polymer1.txt

echo   region 6wall block  0 100 0 100 0 100
echo   fix w1  all wall/region 6wall lj126 1 1 2.5

echo  mass   \*  1

echo  group mc  type 3 4
echo  group AAm type 1 2
echo  group bm  type 2

echo  bond_style   harmonic
echo  bond_coeff   1 10      1.0
echo  bond_coeff   2 10      1.0
echo  bond_coeff   3 100     0.1

echo  angle_style     harmonic
echo  angle_coeff     1 100.0  180.0  

echo  special_bonds   lj 0.0 0.0 0.0
echo  pair_style      soft  1.0
echo  pair_coeff      1  1  1.0   1.0
echo  pair_coeff      1  2  1.0   1.0
echo  pair_coeff      1  3  100   1.0
echo  pair_coeff      1  4  100   1.0
echo  pair_coeff      2  2  1.0   1.0
echo  pair_coeff      2  3  100   1.0
echo  pair_coeff      2  4  100   1.0 
echo  pair_coeff      3  3  10    1.0
echo  pair_coeff      3  4  0     1.0
echo  pair_coeff      4  4  0     1.0

echo  neighbor 1.0 bin
echo  neigh_modify every 1 delay 10 check yes
echo  comm_modify mode single cutoff 3.0

echo  velocity  AAm  create 0.5  ${rand1}   # 1 is temperature, seed for random
echo  fix  1 all nve/limit 0.05 # 0.05 is max distance an atom can move in a timestep
#echo  fix  2 AAm langevin \${T}  \${T}  1.0 ${rand1}

echo   fix m1 bm  move linear 0 0 0


echo  minimize 0.01 0.001 10000 100000
echo timestep 0.01


echo  reset_timestep 0
echo  thermo_style custom step temp  bonds  ebond epair eangle
echo  thermo 1000
#echo  dump 1 all custom   10000 full.lammpstrj id c_imol type x y z
echo  dump 2 all custom   1000 jieguo2.lammpstrj id mol type  x y z #vmd_jieguo图
#echo  dump_modify 1 sort id
echo  dump_modify 2 sort id
echo  run 2000
echo  write_data 2.data
