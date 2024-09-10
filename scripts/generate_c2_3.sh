#!/bin/sh

export SHMEM_OFI_DISABLE_MULTIRAIL=1
export FI_CXI_DEFAULT_CQ_SIZE=131072
export FI_PROVIDER=cxi
export FI_CXI_OPTIMIZED_MRS=0
export EnableImplicitScaling=0

# Put
# Please build first with the appropriate patch as shown below 
## cd $ISHMEM_BUILD_DIR/..
## git apply ishmem_cutover_current.patch
## cd $ISHMEM_BUILD_DIR
## make -j
#

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 1 ' > tmp_1
cat tmp_1 | awk {'printf("%ld\t%lf\n", 8 * $20, $27)'} > tmp_t1

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 16 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $27)'} > tmp_t16

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 128 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $27)'} > tmp_t128

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 1024 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $27)'} > tmp_t1024

paste tmp_t1 tmp_t16 tmp_t128 tmp_t1024 > ishmem_put_wg_bw

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 1 ' > tmp_1
cat tmp_1 | awk {'printf("%ld\t%lf\n", 8 * $20, $24)'} > tmp_t1

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 16 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $24)'} > tmp_t16

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 128 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $24)'} > tmp_t128

mpiexec -n 3 $ISHMEM_BUILD_DIR/../scripts/ishmrun $ISHMEM_BUILD_DIR/test/performance/put_bw -m 4194304 | grep 'test put_bw' | grep 'group<1>' | grep 'threads 1024 ' > tmp_1
cat tmp_1 | awk {'printf("%lf\n", $24)'} > tmp_t1024

paste tmp_t1 tmp_t16 tmp_t128 tmp_t1024 > ishmem_put_wg_lat

rm ./tmp*

