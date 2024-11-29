for i in `seq 1 5`; do

    echo A$i
   rm -r -f A$i
   cp -r source  A$i
   cd A$i

   let k1=i*3+68
   let k2=i*6+17

   echo $k1 $k2 > tmp_random
   ./write_in0.sh  > in.put0

  nohup  lmp_stable -in  in.put0  &

   cd ..
                
 done

