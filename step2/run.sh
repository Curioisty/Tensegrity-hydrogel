for i in `seq 1 3`; do
#   let i=1 
   echo A$i

   cp -r -f source/write_in2.sh   A$i/.

   cd A$i
   
   rm -r -f  log.lammps   log.polymer.txt nohup.out 

   let k1=i*3+2
   let k2=i*6+17

   echo $k1 $k2 > tmp_random
   ./write_in2.sh  > in.put2

  nohup  lmp_stable -in  in.put2  &

   cd ..

#   sleep 1                   
 done

