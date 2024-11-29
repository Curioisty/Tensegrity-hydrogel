for i in `seq 1 3`; do
#   let i=1 
   
   rm -r -f A$i

   echo A$i
    
   cp -r -f source A$i

   cd A$i
   

   let k1=i*3+2
   let k2=i*6+17

   echo $k1 $k2 > tmp_random
   ./write_in1.sh  > in.put1

  nohup  lmp_stable -in  in.put1  &

   cd ..

#   sleep 1                   
 done

