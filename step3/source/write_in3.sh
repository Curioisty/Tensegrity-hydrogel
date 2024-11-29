read   rand1 rand2 < tmp_random
echo   variable T  equal 1.0

echo   units            lj
echo   boundary         p p s 
echo   atom_style       angle
echo   log              log.polymer.txt
echo   read_data        polymer3.txt

echo  mass   \*  1

echo   region 6wall block  0 100 0 100 -30 130
echo   fix w1  all wall/region 6wall lj126 1 1 2.5

echo  region  r_lower   block  0  100  0  100    0  40 
echo  region  r_upper   block  0  100  0  100    60 100


echo  group bm  type 2
echo  group AAm type 1 
echo  group lower region r_lower
echo  group upper region r_upper

echo  group boundary union upper lower
echo  group a_center subtract  all  boundary 


echo  bond_style   harmonic
echo  bond_coeff   1      10      1.0
echo  bond_coeff   2     100      1.0
echo  bond_coeff   3     100      2.0


echo  angle_style     harmonic
echo  angle_coeff     1 1000.0  180.0  

echo  special_bonds   lj 0.0 1.0 1.0
echo  pair_style      lj/cut   2.2448    # 1.1224
echo  pair_coeff        1   1   10   0.5   0.5612
echo  pair_coeff        1   2   10   1.0   1.1224
echo  pair_coeff        1   3  100   1.25  2.0
echo  pair_coeff        1   4  100   1.25  2.0
echo  pair_coeff        2   2   10   1.0   1.1224
echo  pair_coeff        2   3   10   1.25  1.4
echo  pair_coeff        2   4   10   1.25  1.4
echo  pair_coeff        3   3   10   2.0   2.2448
echo  pair_coeff        3   4   10   2.0   2.2448
echo  pair_coeff        4   4   10   2.0   2.2448

echo  neighbor 1.0 bin
echo  neigh_modify every 1 delay 10 check yes
echo  comm_modify mode single cutoff 4.1

echo  velocity  AAm  create  0.01  ${rand1}   # 1 is temperature, seed for random
echo  fix  1 all nve/limit 0.05 # 0.05 is max distance an atom can move in a timestep
echo  fix duanjian AAm bond/break  1000  1  3.0  prob 0.02 ${rand1}

echo timestep 0.01
echo  run 200
echo  reset_timestep 0

echo fix sf1  lower  setforce 0 0 0 
echo fix sf2  upper  setforce 0 0 0 

echo  variable  longforce equal f_sf1[3]-f_sf2[3]
echo  fix myat2 all ave/time 10 10 100 v_longforce file forcetube.dat


echo   fix m1 lower  move linear 0 0 -0.01 units lattice
echo   fix m2 upper  move linear 0 0  0.01 units lattice


echo   compute ss  all stress/atom NULL
echo   compute vol all  voronoi/atom
echo   variable vonpress atom sqrt\(0.5*\(\(c_ss[1]-c_ss[2]\)^2+\(c_ss[1]-c_ss[3]\)^2+\(c_ss[2]-c_ss[3]\)^2+6*\(c_ss[4]^2+c_ss[5]^2+c_ss[6]^2\)\)\)
echo   variable stress equal -pzz*/1.37*1000000
echo   compute newT a_center temp
echo   compute cml lower com
echo   compute cmr upper com

echo  thermo_style custom step temp  bonds ebond pzz c_cml[3]  c_cmr[3]
echo  thermo 1000
echo  thermo_modify temp newT
echo  timestep  0.01
echo  dump 1 AAm  custom   1000    AAm3.crack id mol type  x y z  v_vonpress
echo  dump 2 all  custom   1000 jieguo3.crack id mol type  x y z  v_vonpress  #vmd_jieguo图
echo  dump_modify 1 sort id
echo  dump_modify 2 sort id


echo  run 1000
echo  write_data pull1.data
      
echo  run 4000
echo  write_data pull2.data

echo  run 5000
echo  write_data pull3.data

echo  run 10000
echo  write_data pull4.data

echo  run 30000
echo  write_data pull5.data

echo  run 150000
echo  write_data pull6.data



