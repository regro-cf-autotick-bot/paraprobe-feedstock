
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
mkdir ${SP_DIR}/paraprobe_utils
cp -rf paraprobe-toolbox/code/utils/src/python/* ${SP_DIR}/paraprobe_utils

mkdir ${SP_DIR}/paraprobe_parmsetup
cp -rf paraprobe-toolbox/code/parmsetup/src/python/* ${SP_DIR}/paraprobe_parmsetup

mkdir ${SP_DIR}/paraprobe_reporter
cp -rf paraprobe-toolbox/code/reporter/src/python/* ${SP_DIR}/paraprobe_reporter

mkdir ${SP_DIR}/paraprobe_transcoder
cp -rf paraprobe-toolbox/code/transcoder/src/python/* ${SP_DIR}/paraprobe_transcoder

mkdir ${SP_DIR}/paraprobe_clusterer
cp -rf paraprobe-toolbox/code/clusterer/src/python/* ${SP_DIR}/paraprobe_clusterer


cd paraprobe-toolbox
cd code
#quick fix to get paths right
cp -rf thirdparty ../

cd utils
cp ../../../voro++/src/* src/cxx/
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=mpicxx -DCONDA_PREFIX=${PREFIX} -DLOCAL_INSTALL=OFF .
make
ls
cd ..

mkdir compiled_code
cp utils/CMakeFiles/utils.dir/src/cxx/* compiled_code/

#Tools="ranger selector surfacer distancer tessellator spatstat nanochem intersector"
#for toolname in $Tools; do
#	ls
#	cd $toolname
#	export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
#	cmake -D GITSHA=`git rev-parse HEAD` \
#		  -D Boost_NO_BOOST_CMAKE=ON \
#		  -D CMAKE_BUILD_TYPE=Release \
#		  -D CMAKE_CXX_COMPILER=mpicxx \
#		  -D LOCAL_INSTALL=OFF \
#		  -D CONDA_PREFIX=${PREFIX} .
#	make
#	cp paraprobe_$toolname ${PREFIX}/bin/
#	cd ..
#done

ls
cd ranger
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D GITSHA=`git rev-parse HEAD` \
	  -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_ranger ${PREFIX}/bin/
cd ..

ls
cd selector
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_selector ${PREFIX}/bin/
cd ..

ls
cd surfacer
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_surfacer ${PREFIX}/bin/
cd ..

ls
cd distancer
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_distancer ${PREFIX}/bin/
cd ..

ls
cd tessellator
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_tessellator ${PREFIX}/bin/
cd ..

ls
cd spatstat
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_spatstat ${PREFIX}/bin/
cd ..

ls
cd nanochem
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_nanochem ${PREFIX}/bin/
cd ..

ls
cd intersector
export CXXFLAGS="$CXXFLAGS -DBOOST_ERROR_CODE_HEADER_ONLY"
cmake -D Boost_NO_BOOST_CMAKE=ON \
	  -D CMAKE_BUILD_TYPE=Release \
	  -D CMAKE_CXX_COMPILER=mpicxx \
	  -D LOCAL_INSTALL=OFF \
	  -D CONDA_PREFIX=${PREFIX} .
make
cp paraprobe_intersector ${PREFIX}/bin/
cd ..


mv $mpifort.orig $mpifort
