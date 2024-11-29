for i in `seq 1 5`; do
 
    echo A$i
   rm -r -f A$i
   cp -r ../step0/A$i .
   sleep 1
   cp -r -f source/write_in1.sh   A$i/.

   cd A$i
   
   rm -r -f  log.lammps   log.polymer.txt  nohup.out  tmp.data
   cp polymer1.txt tmp.data
   head -n 16 polymer1.txt  >  polymer2.txt
   tail -n 5760 jieguo1.lammpstrj  >>  polymer2.txt
   sed -i '1,5776d' tmp.data

   cat tmp.data  >>  polymer2.txt

   let k1=i*5+165
   let k2=i*6+17

   echo $k1 $k2 > tmp_random
   ./write_in1.sh  > in.put1

   cd ..

 done

