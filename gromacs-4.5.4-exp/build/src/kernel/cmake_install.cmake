# Install script for directory: /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/src/kernel

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/tomas/programs/gromacs-4.5.4-explosion")
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
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibrariesx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/lib" TYPE SHARED_LIBRARY FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.so.6")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so.6")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibrariesx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/lib" TYPE SHARED_LIBRARY FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.so")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/lib/libgmxpreprocess.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xmdrunx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/mdrun")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/mdrun")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/grompp")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/grompp")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/tpbconv")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/tpbconv")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/pdb2gmx")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/pdb2gmx")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_protonate")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_protonate")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_luck")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_luck")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/gmxdump")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxdump")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/g_x2top")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/g_x2top")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xruntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck"
         RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/bin" TYPE EXECUTABLE FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/gmxcheck")
  if(EXISTS "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck"
         OLD_RPATH "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/mdlib:/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/gmxlib:"
         NEW_RPATH "/home/tomas/programs/gromacs-4.5.4-explosion/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/tomas/programs/gromacs-4.5.4-explosion/bin/gmxcheck")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevelopmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tomas/programs/gromacs-4.5.4-explosion/lib/pkgconfig/libgmxpreprocess.pc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/tomas/programs/gromacs-4.5.4-explosion/lib/pkgconfig" TYPE FILE RENAME "libgmxpreprocess.pc" FILES "/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/kernel/libgmxpreprocess.pc")
endif()

