GPU_CC = nvcc
CC=gcc
CFLAGS =
GPU_SO_CFLAGS = --compiler-options '-fPIC' -shared -L /usr/local/cuda-10.1/targets/x86_64-linux/lib/
GPU_LDFLAGS =  -lcufft
SO_CFLAGS = -fPIC -shared
LDFLAGS = -lfftw3f

C_SRC = cfiles/gmf.c
GPU_SRC = cudafiles/gmfgpu.cu

ALL: libgmf.so

#libgmfgpu.so: gmfgpu.cu
#	$(GPU_CC) $(GPU_SO_CFLAGS) $(GPU_LDFLAGS) gmfgpu.cu -o $@
libgmf.so: $(C_SRC)
	$(CC) $(SO_CFLAGS) $(C_SRC) -o $@ $(LDFLAGS)


libgmfgpu.so: $(GPU_SRC)
	$(GPU_CC) $(GPU_SO_CFLAGS) $(GPU_SRC) -o $@ $(GPU_LDFLAGS)

