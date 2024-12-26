# Definitional proc to organize widgets for parameters.
package require xilinx::board 1.0
namespace import ::xilinx::board::*

proc init_gui { IPINST PROJECT_PARAM.ARCHITECTURE PROJECT_PARAM.BOARD } {
  set c_family ${PROJECT_PARAM.ARCHITECTURE}
  set board ${PROJECT_PARAM.BOARD}
  set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST  -name Component_Name ]
  add_board_tab $IPINST

  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "IP Configuration"]
  set IS_MASTER [ipgui::add_param $IPINST -name "C_IS_MASTER" -parent ${Page_0} -widget comboBox]
  ipgui::add_param $IPINST -name "C_NUM_CHANNELS" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_DWIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_32BIT_LR" -parent ${Page_0} -widget checkBox
  ipgui::add_param $IPINST -name "C_DEPTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_ENABLE_FIFO_COUNT" -parent ${Page_0}

  set_property  visible false $IS_MASTER


}

proc init_params {IPINST PARAM_VALUE.I2STX_BOARD_INTERFACE PARAM_VALUE.C_NUM_CHANNELS PARAM_VALUE.C_IS_MASTER PARAM_VALUE.USE_BOARD_FLOW } {
  set_property preset_proc "I2STX_BOARD_INTERFACE_PRESET" ${PARAM_VALUE.I2STX_BOARD_INTERFACE}
  set boardIfName [get_property value ${PARAM_VALUE.I2STX_BOARD_INTERFACE}]
  if { $boardIfName ne "Custom"} {
    set_property value 2 ${PARAM_VALUE.C_NUM_CHANNELS} 
  	set_property enabled false ${PARAM_VALUE.C_NUM_CHANNELS}
    set_property value 1 ${PARAM_VALUE.C_IS_MASTER} 
  	set_property enabled false ${PARAM_VALUE.C_IS_MASTER}
#	set_property value true ${PARAM_VALUE.USE_BOARD_FLOW}
  } else {
  	set_property enabled true ${PARAM_VALUE.C_NUM_CHANNELS}
	set_property enabled true ${PARAM_VALUE.C_IS_MASTER}
  }
}

proc I2STX_BOARD_INTERFACE_PRESET {IPINST PRESET_VALUE} {
  if { $PRESET_VALUE == "Custom" } {
    return ""
  }
  set board [::ipxit::get_project_property BOARD]
  set vlnv [get_property ipdef $IPINST] 
  set preset_params [board_ip_presets $vlnv $PRESET_VALUE $board "I2S_OUT"]
  if { $preset_params != "" } {
    return $preset_params
  } else {
    return ""
  }
}

proc update_PARAM_VALUE.C_DEPTH { PARAM_VALUE.C_DEPTH } {
	# Procedure called to update C_DWIDTH when any of the dependent parameters in the arguments change
}
proc validate_PARAM_VALUE.C_DEPTH { PARAM_VALUE.C_DEPTH } {
	# Procedure called to validate C_DWIDTH
	return true
}


proc update_PARAM_VALUE.C_DWIDTH { PARAM_VALUE.C_DWIDTH } {
	# Procedure called to update C_DWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DWIDTH { PARAM_VALUE.C_DWIDTH } {
	# Procedure called to validate C_DWIDTH
	return true
}

proc update_PARAM_VALUE.C_IS_MASTER { PARAM_VALUE.C_IS_MASTER PARAM_VALUE.I2STX_BOARD_INTERFACE } {
	# Procedure called to update C_IS_MASTER when any of the dependent parameters in the arguments change
  set boardIfName [get_property value ${PARAM_VALUE.I2STX_BOARD_INTERFACE}]
  if { $boardIfName ne "Custom"} {
    set_property value 1 ${PARAM_VALUE.C_IS_MASTER} 
  	set_property enabled false ${PARAM_VALUE.C_IS_MASTER}
  } else {
  	set_property enabled true ${PARAM_VALUE.C_IS_MASTER}
  }
}

proc validate_PARAM_VALUE.C_IS_MASTER { PARAM_VALUE.C_IS_MASTER } {
	# Procedure called to validate C_IS_MASTER
	return true
}

proc update_PARAM_VALUE.I2STX_BOARD_INTERFACE {PARAM_VALUE.I2STX_BOARD_INTERFACE IPINST PROJECT_PARAM.BOARD} {
  set param_range [get_board_interface_param_range $IPINST -name "I2STX_BOARD_INTERFACE"]
  set_property range $param_range ${PARAM_VALUE.I2STX_BOARD_INTERFACE}
}

proc validate_PARAM_VALUE.I2STX_BOARD_INTERFACE { PARAM_VALUE.I2STX_BOARD_INTERFACE } {
	# Procedure called to validate I2STX_BOARD_INTERFACE
	return true
}

proc update_PARAM_VALUE.USE_BOARD_FLOW {PARAM_VALUE.USE_BOARD_FLOW PARAM_VALUE.I2STX_BOARD_INTERFACE} {
# Procedure called to update USE_BOARD_FLOW when any of the dependent parameters in the arguments change
#  set boardIfName [get_property value ${PARAM_VALUE.I2STX_BOARD_INTERFACE}]
#  if { $boardIfName ne "Custom"} {
#    set_property value true ${PARAM_VALUE.USE_BOARD_FLOW} 
#  }
}

proc validate_PARAM_VALUE.USE_BOARD_FLOW { PARAM_VALUE.USE_BOARD_FLOW } {
	# Procedure called to validate USE_BOARD_FLOW
	return true
}



proc update_PARAM_VALUE.C_32BIT_LR { PARAM_VALUE.C_32BIT_LR } {
	# Procedure called to update C_IS_MASTER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_32BIT_LR { PARAM_VALUE.C_32BIT_LR } {
	# Procedure called to validate C_IS_MASTER
	return true
}

proc update_PARAM_VALUE.C_NUM_CHANNELS { PARAM_VALUE.C_NUM_CHANNELS PARAM_VALUE.I2STX_BOARD_INTERFACE } {
	# Procedure called to update C_NUM_CHANNELS when any of the dependent parameters in the arguments change
  set boardIfName [get_property value ${PARAM_VALUE.I2STX_BOARD_INTERFACE}]
  if { $boardIfName ne "Custom"} {
    set_property value 2 ${PARAM_VALUE.C_NUM_CHANNELS} 
  	set_property enabled false ${PARAM_VALUE.C_NUM_CHANNELS}
  } else {
  	set_property enabled true ${PARAM_VALUE.C_NUM_CHANNELS}
  }
}

proc validate_PARAM_VALUE.C_NUM_CHANNELS { PARAM_VALUE.C_NUM_CHANNELS } {
	# Procedure called to validate C_NUM_CHANNELS
	return true
}

proc update_PARAM_VALUE.C_ENABLE_FIFO_COUNT { PARAM_VALUE.C_ENABLE_FIFO_COUNT } {
	# Procedure called to update C_ENABLE_FIFO_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ENABLE_FIFO_COUNT { PARAM_VALUE.C_ENABLE_FIFO_COUNT } {
	# Procedure called to validate C_ENABLE_FIFO_COUNT
	return true
}


proc update_MODELPARAM_VALUE.C_IS_MASTER { MODELPARAM_VALUE.C_IS_MASTER PARAM_VALUE.C_IS_MASTER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	#set local_v [get_property value ${PARAM_VALUE.C_IS_MASTER}]
        #if {$local_v == 1} {
        #   set value 1
        #} else {
        #   set value 0
        #}
	#set_property value $value ${MODELPARAM_VALUE.C_IS_MASTER}
	
        set_property value [get_property value ${PARAM_VALUE.C_IS_MASTER}] ${MODELPARAM_VALUE.C_IS_MASTER}
}

proc update_MODELPARAM_VALUE.C_32BIT_LR { MODELPARAM_VALUE.C_32BIT_LR PARAM_VALUE.C_32BIT_LR } {
	
        set_property value [get_property value ${PARAM_VALUE.C_32BIT_LR}] ${MODELPARAM_VALUE.C_32BIT_LR}
}


proc update_MODELPARAM_VALUE.C_NUM_CHANNELS { MODELPARAM_VALUE.C_NUM_CHANNELS PARAM_VALUE.C_NUM_CHANNELS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set local_v [get_property value ${PARAM_VALUE.C_NUM_CHANNELS}]
        set local_v [expr $local_v/2]
	set_property value $local_v ${MODELPARAM_VALUE.C_NUM_CHANNELS}
}

proc update_MODELPARAM_VALUE.C_DWIDTH { MODELPARAM_VALUE.C_DWIDTH PARAM_VALUE.C_DWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DWIDTH}] ${MODELPARAM_VALUE.C_DWIDTH}
}

proc update_MODELPARAM_VALUE.C_DEPTH { MODELPARAM_VALUE.C_DEPTH PARAM_VALUE.C_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DEPTH}] ${MODELPARAM_VALUE.C_DEPTH}
}