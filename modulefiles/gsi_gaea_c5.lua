help([[
  This module loads libraries required for building and running GSI
  on the NOAA RDHPC machine Gaea C5 using Intel-2023.1.0.
]])

whatis("Description: GSI environment on Cheyenne with GNU Compilers")

load("PrgEnv-intel/8.3.3")
load("intel-classic/2023.1.0")
load("cray-mpich/8.1.25")
load("python/3.9.12")

prepend_path("MODULEPATH", "/lustre/f2/dev/wpo/role.epic/contrib/spack-stack/c5/spack-stack-dev-20230717/envs/unified-env/install/modulefiles/Core")
prepend_path("MODULEPATH", "/lustre/f2/dev/wpo/role.epic/contrib/spack-stack/c5/modulefiles")
prepend_path("MODULEPATH", "/lustre/f2/dev/Samuel.Trahan/hafs/modulefiles/")

stack_intel_ver=os.getenv("stack_intel_ver") or "2023.1.0"
load(pathJoin("stack-intel", stack_intel_ver))

stack_cray_mpich_ver=os.getenv("stack_cray_mpich_ver") or "8.1.25"
load(pathJoin("stack-cray-mpich", stack_cray_mpich_ver))

stack_python_ver=os.getenv("stack_python_ver") or "3.9.12"
load(pathJoin("stack-python", stack_python_ver))

local ufs_modules = {
  {["bufr"]            = "11.7.0"},
  {["bacio"]           = "2.4.1"},
  {["w3emc"]           = "2.9.2"},
  {["sp"]              = "2.3.3"},
  {["ip"]              = "3.3.3"},
  {["sigio"]           = "2.3.2"},
  {["sfcio"]           = "1.4.1"},
  {["nemsio"]          = "2.5.4"},
  {["wrf-io"]          = "1.2.0"},
  {["ncio"]            = "1.1.2"},
  {["crtm"]            = "2.4.0"},
  {["gsi-ncdiag"]      = "1.1.1"},
}

for i = 1, #ufs_modules do
  for name, default_version in pairs(ufs_modules[i]) do
    local env_version_name = string.gsub(name, "-", "_") .. "_ver"
    load(pathJoin(name, os.getenv(env_version_name) or default_version))
  end
end

load("rocoto")

unload("darshan-runtime")
unload("cray-libsci")

setenv("CC", "cc")
setenv("CXX", "CC")
setenv("FC", "ftn")
