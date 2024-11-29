for i in `seq 1 3`; do

   echo A$i

   cp -r -f source/write_in3.sh   A$i/.

   cd A$i
   
   rm -r -f  log.lammps   log.polymer.txt nohup.out 

   let k1=i*3+2
   let k2=i*6+17

   echo $k1 $k2 > tmp_random
   ./write_in4.sh  > in.put4

  nohup  lmp_stable -in  in.put4  &

   cd ..
               
 done

