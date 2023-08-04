include(CheckCSourceCompiles)
include(CheckCXXSourceCompiles)

macro(append_c_compiler_flags _flags _name _result)
  set(SAFE_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
  string(REGEX REPLACE "[-+/ ]" "_" cname "${_name}")
  string(TOUPPER "${cname}" cname)
  foreach(flag ${_flags})
    string(REGEX REPLACE "^[-+/ ]+(.*)[-+/ ]*$" "\\1" flagname "${flag}")
    string(REGEX REPLACE "[-+/ ]" "_" flagname "${flagname}")
    string(TOUPPER "${flagname}" flagname)
    set(have_flag "HAVE_${cname}_${flagname}")
    set(CMAKE_REQUIRED_FLAGS "${flag}")
    check_c_source_compiles("int main() { return 0; }" ${have_flag})
    if(${have_flag})
      set(${_result} "${${_result}} ${flag}")
    endif(${have_flag})
  endforeach(flag)
  set(CMAKE_REQUIRED_FLAGS ${SAFE_CMAKE_REQUIRED_FLAGS})
endmacro(append_c_compiler_flags)

macro(append_cxx_compiler_flags _flags _name _result)
  set(SAFE_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
  string(REGEX REPLACE "[-+/ ]" "_" cname "${_name}")
  string(TOUPPER "${cname}" cname)
  foreach(flag ${_flags})
    string(REGEX REPLACE "^[-+/ ]+(.*)[-+/ ]*$" "\\1" flagname "${flag}")
    string(REGEX REPLACE "[-+/ ]" "_" flagname "${flagname}")
    string(TOUPPER "${flagname}" flagname)
    set(have_flag "HAVE_${cname}_${flagname}")
    set(CMAKE_REQUIRED_FLAGS "${flag}")
    check_cxx_source_compiles("int main() { return 0; }" ${have_flag})
    if(${have_flag})
      set(${_result} "${${_result}} ${flag}")
    endif(${have_flag})
  endforeach(flag)
  set(CMAKE_REQUIRED_FLAGS ${SAFE_CMAKE_REQUIRED_FLAGS})
endmacro(append_cxx_compiler_flags)
