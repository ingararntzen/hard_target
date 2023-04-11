GPU_CC = nvcc
CC = gcc
CFLAGS =
GPU_SO_CFLAGS = --compiler-options '-fPIC' -shared -L /usr/local/cuda-10.1/targets/x86_64-linux/lib/
GPU_LDFLAGS =  -lcufft
SO_CFLAGS = -fPIC -shared
LDFLAGS = -lfftw3f

# Directories
C_SRC = cfiles
GPU_SRC = cudafiles
BUILD_DIR = bin

# Create the build directory if it doesn't exist
$(shell mkdir -p $(BUILD_DIR))

ALL: libgmf libgmfgpu
libgmf: libgmf.so
libgmfgpu: libgmfgpu.so

libgmf.so: $(C_SRC)/gmf.c
	$(CC) $(SO_CFLAGS) -o $(BUILD_DIR)/$@ $< $(LDFLAGS)

libgmfgpu.so: $(GPU_SRC)/gmfgpu.cu
	$(GPU_CC) $(GPU_SO_CFLAGS) -o $(BUILD_DIR)/$@  $< $(GPU_LDFLAGS)

realclean:
	rm -rf $(BUILD_DIR)
