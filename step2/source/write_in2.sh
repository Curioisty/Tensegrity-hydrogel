read   rand1 rand2 < tmp_random
echo   variable T  equal 1.0

echo   units            lj
echo   boundary         s s s 
echo   atom_style       angle
echo   log              log.polymer.txt
echo   read_data        polymer2.txt

echo  mass   \*  1

echo   region 6wall block  0 110 0 110 0 110
echo   fix w1  all wall/region 6wall lj126 1 1 2.5

echo  region  r_center   block  2  98  2 98 2 98
echo  group a_center region r_center
echo  group a_boundary  subtract  all a_center

echo  group AAm type 1 2

echo  bond_style   harmonic
echo  bond_coeff   1 10      1.0  #PAAm
echo  bond_coeff   2 50      1.0    
echo  bond_coeff   3 500     0.2


echo  angle_style     harmonic
echo  angle_coeff     1 1000.0  180.0  

echo  special_bonds   lj 0.0 0.0 0.0
echo  pair_style      lj/cut  2.2448  # 1.1224
echo  pair_coeff      	1   1   10     1   1.1224
echo  pair_coeff        1   2   10     1   1.1224
echo  pair_coeff        1   3   10     1.5 2.0
echo  pair_coeff        1   4   10     1.5 2.0 
echo  pair_coeff        2   2   10     1   1.1224
echo  pair_coeff        2   3   10     1.5 2.0
echo  pair_coeff        2   4   10     1.5 2.0
echo  pair_coeff        3   3   10    1.0   1.1224
echo  pair_coeff        3   4    0    0.1   0.11
echo  pair_coeff        4   4    0    0.1   0.11

echo  neighbor 1.0 bin
echo  neigh_modify every 1 delay 10 check yes
#echo  neigh_modify exclude type 2 3
echo  comm_modify mode single cutoff 4.0

echo  velocity  AAm  create \${T}  ${rand1}   # 1 is temperature, seed for random
echo  fix  1 all nve/limit 0.05 # 0.05 is max distance an atom can move in a timestep
echo  fix  2 AAm langevin \${T}  \${T}  1.0 ${rand1}
echo  fix duanjian AAm bond/break 1000 1  2.0  prob 0.002  ${rand1}
#echo  fix m1 a_boundary  move linear 0 0 0


echo   compute ss all stress/atom NULL
echo   compute vol all voronoi/atom
echo   variable vonpress atom sqrt\(0.5*\(\(c_ss[1]-c_ss[2]\)^2+\(c_ss[1]-c_ss[3]\)^2+\(c_ss[2]-c_ss[3]\)^2+6*\(c_ss[4]^2+c_ss[5]^2+c_ss[6]^2\)\)\)
echo   variable stress equal -pzz*/1.37*1000000



echo timestep 0.01
echo  thermo_style custom step temp  bonds  ebond epair eangle
echo  thermo 1000
echo  dump 1 AAm custom   1000    AAm3.crack id mol type  x y z  v_vonpress
echo  dump 2 all custom   1000 jieguo3.crack id mol type  x y z  v_vonpress  #vmd_jieguo图
echo  dump_modify 1 sort id
echo  dump_modify 2 sort id

echo  run 5000
echo  write_data a1.data


echo  bond_coeff 3 1000  0.4
echo  run 5000
echo  write_data a2.data
echo  pair_coeff        3   3    50   2.0   2.2448
echo  pair_coeff        3   4   100   0.5   0.56
echo  pair_coeff        4   4   100   0.5   0.56
echo  bond_coeff 3 1000  0.6
echo  run 10000
echo  write_data a3.data       


echo  bond_coeff 3 1000  0.8
echo  run 10000
echo  write_data a4.data 


echo  pair_coeff        3   4   50   0.8   0.89
echo  pair_coeff        4   4   50   0.8   0.89
echo  bond_coeff 3 1000  1.0
echo  run 10000
echo  write_data a5.data 

echo  bond_coeff 3 1000  1.2
echo  run 5000
echo  write_data a6.data 


echo  bond_coeff 3 1000  1.4
echo  run 5000
echo  write_data a7.data 

echo  pair_coeff        3   4   50   1.5   1.68
echo  pair_coeff        4   4   50   1.5   1.68
echo  bond_coeff 3 1000  1.6
echo  run 10000
echo  write_data a8.data 

echo  bond_coeff 3 1000  1.8
echo  run 5000
echo  write_data a9.data        


echo  pair_coeff        3   4   50   2.0   2.2448
echo  pair_coeff        4   4   50   2.0   2.2448
echo  bond_coeff 3 1000  2.0
echo  run 10000
echo  write_data a10.data



