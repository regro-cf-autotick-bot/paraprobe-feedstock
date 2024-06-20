
mpifort=$(which mpifort)
mv $mpifort $mpifort.orig
sed 's/\(enable_wrapper_rpath=\)"yes"/\1"no"/' $mpifort.orig >$mpifort
chmod +x $mpifort

echo ${SP_DIR}

# third-party dependencies
cp paraprobe-toolbox/code/thirdparty/mandatory/voroxx/voro++-0.4.6.tar.xz .
tar xvf voro++-0.4.6.tar.xz
mv voro++-0.4.6 voro++

#test python building
PythonTools="utils parmsetup reporter transcoder clusterer"
for toolname in $PythonTools; do
	mkdir ${SP_DIR}/paraprobe_${toolname}
	cp -rf paraprobe-toolbox/code/${toolname}/src/python/* ${SP_DIR}/paraprobe_${toolname}
done

cd paraprobe-toolbox
cd code
#quick fix to get paths right
cp -rf thirdparty ../

ls
cd utils
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cp ../../../voro++/src/* src/cxx/
cmake -D GITSHA="v0.5.1" \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} \
	  -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx .
make
ls
cd ..
mkdir compiled_code
cp utils/CMakeFiles/utils.dir/src/cxx/* compiled_code/


CxxTools="ranger selector surfacer distancer tessellator spatstat nanochem intersector"
for toolname in $CxxTools; do
	ls
	cd $toolname
	export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
	cmake -D GITSHA="v0.5.1" \
		  -D LOCAL_INSTALL=OFF \
		  -D CONDA_PREFIX=${PREFIX} \
		  -D Boost_NO_BOOST_CMAKE=ON \
		  -D CMAKE_BUILD_TYPE=Release \
		  -D CMAKE_CXX_COMPILER=mpicxx .
	make
	cp paraprobe_$toolname ${PREFIX}/bin/
	cd ..
done


mv $mpifort.orig $mpifort
