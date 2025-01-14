#
# Copyright (c) 2009-2011 Open Source Medical Software Corporation,
#                         University of California, San Diego.
#
# All rights reserved.
#
# See SimVascular Acknowledgements file for additional
# contributors to the source code.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

global auto_path

if {$SV_RELEASE_BUILD == 0} {
  source $simvascular_home/Tcl/Common/General/tmpobj.tcl
  source $simvascular_home/Tcl/Common/General/helpers.tcl
}

# ----------------
# Set up auto_path
# ----------------
set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/SimVascular_2.0/Core]

# need package xml
lappend auto_path [file join $simvascular_home Tcl External tclxml3.2]

# gui stuff
if {[info exists env(SV_BATCH_MODE)] == 0} {

  if {$SV_RELEASE_BUILD == 0} {
    source $simvascular_home/Tcl/Common/Vis/actor.tcl
    source $simvascular_home/Tcl/Common/Vis/obj.tcl
    source $simvascular_home/Tcl/Common/Vis/img.tcl
    source $simvascular_home/Tcl/Common/Vis/ren.tcl
    source $simvascular_home/Tcl/Common/Vis/tk.tcl
    source $simvascular_home/Tcl/Common/Vis/init.tcl
    source $simvascular_home/Tcl/Common/Vis/text.tcl
    source $simvascular_home/Tcl/Common/Vis/poly.tcl
  }
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/Common/Visualization]
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/Common/Vis]
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/Common/General]
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/OSMSC]
    package require tile
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/SimVascular_2.0/Core]
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/SimVascular_2.0/GUI]
    set auto_path [linsert $auto_path 0 $simvascular_home/Tcl/SimVascular_2.0/Plugins]
}

proc upix {} {
  global auto_path
  set start [pwd]
  foreach dir $auto_path {
    if {[file owned $dir]} {
      cd $dir
      if {[llength [glob -nocomplain *.tcl]] > 0} {
        catch {auto_mkindex . *.tcl}
      }
    }
  }
  cd $start
}

# wrap the call to upix so that it *can* be disabled in released versions
if {$SV_RELEASE_BUILD == 0} {
  # if we are running in batch mode, can't
  # regenerate the indexes constantly or
  # else auto_index gets confused
  if {[info exists env(SV_BATCH_MODE)] == 0} {
    upix
  }
}

global SV_SHARED_BUILD
if {[info exists SV_SHARED_BUILD] == 0} {
  set SV_SHARED_BUILD "OFF"
}
if {$SV_SHARED_BUILD == "ON"} {
  source [file join $env(SV_HOME) Tcl SimVascular_2.0 Core simvascular_load_shared_libs.tcl]
}
set lib_ext so
if {$tcl_platform(os) == "Darwin"} {
  set lib_ext dylib
} elseif {$tcl_platform(platform) == "windows"} {
  set lib_ext dll
}

# load commercial packages if dynamically built
if {[catch {load $env(SV_HOME)/Lib/liblib_simvascular_parasolid.$lib_ext Parasolidsolid} msg]} {
  if {$SV_SHARED_BUILD == "ON"} {
    puts [format "  %-12s %s" "Parasolid:" Unavailable]
  }
  #puts "liblib_simvascular_parasolid $lib_ext: $msg"
}
if {[catch {load $env(SV_HOME)/Lib/liblib_simvascular_discrete.$lib_ext Meshsimdiscretesolid} msg]} {
  if {$SV_SHARED_BUILD == "ON"} {
    puts [format "  %-12s %s" "Discrete:" Unavailable]
  }
  #puts "liblib_simvascular_meshsim_discrete $lib_ext: $msg"
}
if {[catch {load $env(SV_HOME)/Lib/liblib_simvascular_meshsim_mesh.$lib_ext Meshsimmesh} msg]} {
  if {$SV_SHARED_BUILD == "ON"} {
    puts [format "  %-12s %s" "MeshSim:" Unavailable]
  }
  #puts "liblib_meshsim_mesh $lib_ext: $msg"
}
if {[catch {load $env(SV_HOME)/Lib/liblib_simvascular_meshsim_adaptor.$lib_ext  Meshsimadapt} msg]} {
  if {$SV_SHARED_BUILD == "ON"} {
    puts [format "  %-12s %s" "" "MeshSim Adaption Unavailable"]
  }
  #puts "liblib_simvascular_meshsim_adaptor $lib_ext: $msg"
}
