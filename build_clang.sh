#! /bin/sh

CLANG_RELEASE=RELEASE_701
rm -rf llvm
rm -rf llvm-build
svn co http://llvm.org/svn/llvm-project/llvm/tags/${CLANG_RELEASE}/final llvm
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/tags/${CLANG_RELEASE}/final clang

cd ../../llvm-build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release  -DLLVM_ENABLE_ASSERTIONS=NO \
  -DLLVM_ENABLE_THREADS=NO -DLLVM_ENABLE_TERMINFO=OFF \
  -DCMAKE_CXX_STANDARD_LIBRARIES="-static-libgcc -static-libstdc++" \
  ../llvm/

ninja clang-format
strip bin/clang-format

tar cf clang-format.tar.gz bin/clang-format
