# Install script for directory: /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/kernel

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/ibrahim/programs/gromacs-4.5.4-explosion")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6"
      "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    endif()
  endforeach()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6;/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib" TYPE SHARED_LIBRARY FILES
    "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.so.6"
    "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.so"
    )
  foreach(file
      "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6"
      "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
           NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "mdrun" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/mdrun")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/mdrun")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/grompp")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/grompp")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/tpbconv")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/pdb2gmx")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_protonate")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_luck")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_luck")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/gmxdump")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_x2top")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck"
         RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/gmxcheck")
  if(EXISTS "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck"
         OLD_RPATH "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ibrahim/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "development" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/pkgconfig/libgmxpreprocess.pc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ibrahim/programs/gromacs-4.5.4-explosion/lib/pkgconfig" TYPE FILE RENAME "libgmxpreprocess.pc" FILES "/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.pc")
endif()

