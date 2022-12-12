# coding=utf-8
import os
import sys
import numpy as np
#from Scatterlib import *
import matplotlib.pyplot as plt
from matplotlib import rc
from scipy.interpolate import interp1d
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
import argparse
import joblib
from joblib import Parallel, delayed
import time

rc('font',**{'family':'sans-serif','sans-serif':['Helvetica']})
rc('text', usetex=True)
plt.rc('font', family='serif')

### READ INPUT ###  
parser = argparse.ArgumentParser()
parser.add_argument("intensity", help="Intensity of pulse in W/cm^2")
parser.add_argument("path_to_PDB", help="Path to PDB file used.")
args = parser.parse_args()
RUN = args.intensity
path_to_PDB = args.path_to_PDB

### END OF INPUT ### 

def get_atom_info(path_to_PDB):
	#path_to_PDB = "./sphere_829806_relaxed.pdb"

	""" Returns the atom indices and names. """
	f = open(path_to_PDB, "r")
	lines = f.readlines()

	atoms = []
	indices = []
	indx = 1
	for line in lines:
		if "ATOM" in line:
			indices.append(indx)
			atoms.append(line.split()[2])
			indx+=1
	return atoms, indices

def read_run_file(run_file):
    """ Reads a file and returns the lines. """
    f_run = open(run_file)
    lines_run = f_run.readlines()
    f_run.close()
    return lines_run

def interpolate_charge_states(charge_data):
    """ Interpolate the fractional charge data assuming a timestep of 1e-17s. """
    num_atomic_states = (np.shape(charge_data)[0])
    for i in range(num_atomic_states):
        x = time
        y = charge_data[i]
        charge_data[i] = interpolate_data(x,y)
    return charge_data

def get_configs(atom, path_to_data):
    """ Get the fractional charge data for a specific atom and zone. """
    path_to_menu = path_to_data +"menu"
    f = open(path_to_menu, "r")
    lines = f.readlines()
    time_resolved_charge_state = []
    configs = []
    for line in lines:

        if "ynf" and atom in line and "yisofrac" not in line and "ZBAR" not in line: # in line and atom in line and "zone " + str(zone
                #print(line.split()[3].split("_"))
         
                config = [int(i) for i in line.split()[3].split("_")[1:]] 
                if len(config) == 2:
                    config = config + [0,0]
                if len(config) == 1:
                    config = config + [0,0,0]

                configs.append(config)
                 
    return configs

def reverse_config(path_to_data):
    configs = get_configs("oxygen", path_to_data)
    config_temp = []
    for i in range(len(configs)-1, -1, -1):
        if configs[i]==[]:
            continue
        print(configs[i])
        config_temp.append(configs[i])
    #print(config_temp)
    configs = config_temp
    #print(configs)
    return configs

def get_atom_data(atom, path_to_data, interpolate):
    """ Get the fractional charge data for a specific atom and zone. """
    path_to_menu = path_to_data +"menu"
    f = open(path_to_menu, "r")
    lines = f.readlines()
    time_resolved_charge_state = []
    configs = []
    for line in lines:

        if "ynf" and atom in line and "yisofrac" not in line and "ZBAR" not in line: # in line and atom in line and "zone " + str(zone
                #print(line.split()[3].split("_"))

                print(line)
                config = [int(i) for i in line.split()[3].split("_")[1:]] 
                print(len(config), config)  
                if len(config) == 2:
                    config = config + [0,0]
                if len(config) == 1:
                    config = config + [0,0,0]
                print(config)
                print(config)
                 
            #[0,0]
                #print(config)
                configs.append(config)
                run_file = path_to_data + line.split()[0]
                run = read_run_file(run_file)
                fractional_charge_state = []
                time = []
                for data in run:

                    if "#" not in data:
                        #x = [float(value) for (value) in data.split()[1:]]
                        x = float(data.split()[3])
                       # print(x)
                        
                        time.append(float(data.split()[0]))
                        fractional_charge_state.append(x)
                        #fractional_charge_state.append(np.mean(x))
                #print(fractional_charge_state)
                time_resolved_charge_state.append(fractional_charge_state)


    for time in range(np.shape(time_resolved_charge_state)[1]):
        break
        if np.abs(np.sum(np.array(time_resolved_charge_state)[:,time])-1)>0.001:
            print("Not summing to 1, exiting.")
            print(np.sum(np.array(time_resolved_charge_state)[:,time]))
            exit(0)
        print(np.sum(np.array(time_resolved_charge_state)[:,time]), time)
        #print(np.shape(np.array(time_resolved_charge_state)[:,time]))
    #exit(0)

    if interpolate == True:
        dt = 1e-17
        new_time = np.linspace(0, 75e-15, round((75e-15)/dt)+1)
        for indx in range(np.shape(time_resolved_charge_state)[0]):
            f = interp1d(time, time_resolved_charge_state[indx])
            time_resolved_charge_state[indx] = f(new_time)
        time = new_time
                
    return time, time_resolved_charge_state, configs

def get_atom_data_YNF(atom, path_to_data, interpolate):
    """ Get the fractional charge data for a specific atom and zone. """
    path_to_menu = path_to_data +"menu"
    f = open(path_to_menu, "r")
    lines = f.readlines()
    time_resolved_charge_state = []
    configs = []
    for line in lines:

        if "ynf" and atom in line and "yisofrac" not in line and "ZBAR" not in line: # in line and atom in line and "zone " + str(zone
                #print(line.split()[3].split("_"))

                print(line)
                config = [int(i) for i in line.split()[3].split("_")[1:]] 
                print(len(config), config)  
                if len(config) == 2:
                    config = config + [0,0]
                if len(config) == 1:
                    config = config + [0,0,0]
                print(config)
                print(config)
                 
            #[0,0]
                #print(config)
                configs.append(config)
                run_file = path_to_data + line.split()[0]
                run = read_run_file(run_file)
                fractional_charge_state = []
                time = []
                for data in run:
                    #print(data.split())
                    if "#" not in data:
                        x = [float(value) for (value) in data.split()[1:]]
                        #x = float(data.split()[3])
                       # print(x)
                        
                        time.append(float(data.split()[0]))
                        #fractional_charge_state.append(x)
                        fractional_charge_state.append(np.mean(x))
                #print(fractional_charge_state)
                time_resolved_charge_state.append(fractional_charge_state)


    for time in range(np.shape(time_resolved_charge_state)[1]):
        break
        if np.abs(np.sum(np.array(time_resolved_charge_state)[:,time])-1)>0.001:
            print("Not summing to 1, exiting.")
            print(np.sum(np.array(time_resolved_charge_state)[:,time]))
            break
            exit(0)
        print(np.sum(np.array(time_resolved_charge_state)[:,time]), time)
        #print(np.shape(np.array(time_resolved_charge_state)[:,time]))
    #exit(0)

    if interpolate == True:
        dt = 1e-17
        new_time = np.linspace(0, 75e-15, round((75e-15)/dt)+1)
        for indx in range(np.shape(time_resolved_charge_state)[0]):
            f = interp1d(time, time_resolved_charge_state[indx])
            time_resolved_charge_state[indx] = f(new_time)
        time = new_time
                
    return time, time_resolved_charge_state, configs

def get_atom_data_yisofrac(atom, path_to_data, interpolate):
    """ Get the fractional charge data for a specific atom and zone. """
    path_to_menu = path_to_data +"menu"
    f = open(path_to_menu, "r")
    lines = f.readlines()
    time_resolved_charge_state = []
    configs = []
    for line in lines:

        if "yisofrac" in line and atom in line: # in line and atom in line and "zone " + str(zone
                #print(line.split()[3].split("_"))

                print(line)
                run_file = path_to_data + line.split()[0]
                run = read_run_file(run_file)
                fractional_charge_state = []
                time = []
                for data in run:
                    #print(data.split())
                    if "#" not in data:
                        #print(data)
                        x = [float(value) for (value) in data.split()[1:]]
                        #x = float(data.split()[3])
                       # print(x)
                        
                        time.append(float(data.split()[0]))
                        #fractional_charge_state.append(x)
                        fractional_charge_state.append(np.mean(x))
                #print(fractional_charge_state)
                time_resolved_charge_state.append(fractional_charge_state)

    if interpolate == True:
        dt = 1e-17
        new_time = np.linspace(0, 75e-15, round((75e-15)/dt)+1)
        for indx in range(np.shape(time_resolved_charge_state)[0]):
            f = interp1d(time, time_resolved_charge_state[indx])
            time_resolved_charge_state[indx] = f(new_time)
        time = new_time
                
    return time, time_resolved_charge_state, configs

def plot_interpolated_vs_data():
    for state in range(num_states): 
        if state == 5:
            break
        plt.plot(time, time_resolved_charge_state[state], "--")
        plt.plot(time_interpolated, time_resolved_charge_state_interpolated[state])

    plt.show()

def get_electron_data(path_to_data):
    """ Gets free electron density and temeperature which is necessary to calculate the Debye length. """
    #path_to_data = "/home/HDD16TB/scratch/ibrahim/Ice/Ice_damage_data/DAVINCI/75fs_ice_multiple_intensities_ener8000/fwhm-50/fl-1e+18/run_ice.plots/"
    #path_to_data ="/home/ibrahim/projects/ice/2022-10-03/previous_ice_simulations/SIMULATIONS/75fs_ice_multiple_intensities_ener8000/fwhm-50/fl-{0}/run_ice.plots/".format(RUN)
    path_to_menu = path_to_data + "menu"
    f = open(path_to_menu, "r")
    lines = f.readlines()
    time_resolved_debye_length = []
    time_resolved_tev = []
    time_resolved_ne = []
    time = []
    for line in lines:

        if "TEV" in line:
            print(line)
            path_to_file = path_to_data + line.split()[0]
            run = (read_run_file(path_to_file))
            for data in run:
                if "$" not in data:
                    x = [float(data.split()[i]) for i in range(1, len(data.split()))]
                   #print(x)
                    time_resolved_tev.append(x)
                    time.append(float(data.split()[0]))
    for line in lines:
        if "E-DENS" in line:
                print(line)
                path_to_file = path_to_data + line.split()[0]
                run = (read_run_file(path_to_file))
                for data in run:
                    if "$" not in data:
                        x = [float(data.split()[i]) for i in range(1, len(data.split()))]
                       #print(x)
                        time_resolved_ne.append(x)
    return time, time_resolved_tev, time_resolved_ne

def get_number_of_atoms(path_to_PDB):
    """ Get the number of atoms for each specific atomic species for the sample used. """
    fle = open(path_to_PDB, "r")
    oxygens = 0
    nitrogens = 0
    carbons = 0 
    zincs = 0
    sulfurs = 0
    hydrogens = 0
    for line in fle.readlines():
        if "ATOM" in line:
            if "O" == (line.split()[2]):
                oxygens +=1
            if "N" == (line.split()[2]):
                nitrogens +=1
            if "C" == (line.split()[2]):
                carbons +=1
            if "ZN" == (line.split()[2]):
                zincs +=1
            if "S" == (line.split()[2]):
                sulfurs +=1
            if "H" == (line.split()[2]):
                hydrogens +=1
    return oxygens, nitrogens, carbons, zincs, sulfurs, hydrogens

def write_atom_file(output_path, time_resolved_data, atom, number_of_atoms):
    """ Write to a file the number of atoms for each charge state as a function of time (done for a specific atomic species). """
    f = open(output_path + "/" + atom + ".txt", "w")
    number_of_charge_states = (np.shape(time_resolved_data)[0])
    steps = (np.shape(time_resolved_data)[1])
    print(number_of_charge_states)
   # exit(0)
    #for t in range(len(time)):
    for t in range(steps):
        charge_states = []
        for i in range(number_of_charge_states-1, -1, -1):
            data = np.rint(number_of_atoms*time_resolved_data[i][t])
            charge_states.append(data)
        correct_numbers = True
        if correct_numbers == True:
            if int(np.sum(charge_states))!=number_of_atoms: # if the total number does not equal the number of atoms for the particular atom add the difference 
				diff = number_of_atoms-int(np.sum(charge_states))
				indx = np.where(np.max(charge_states)==charge_states)

				print("Corrected with amount: {0}".format(diff))
				charge_states[indx[0][0]] +=diff

        for i in range(number_of_charge_states):
            f.writelines(str(np.abs(charge_states[i])) + " ")     
        f.writelines("\n")
    f.close()


def write_atom_file_ynf(output_path, time_resolved_data, atom, number_of_atoms):
    """ Write to a file the number of atoms for each charge state as a function of time (done for a specific atomic species). """
    f = open(output_path + "/" + atom + "_ynf.txt", "w")
    number_of_charge_states = (np.shape(time_resolved_data)[0])
    steps = (np.shape(time_resolved_data)[1])

    #for t in range(len(time)):
    for t in range(steps):
        charge_states = []
        for i in range(number_of_charge_states-1, -1, -1):
            data = np.rint(number_of_atoms*time_resolved_data[i][t])
            charge_states.append(data)

        correct_numbers = True
        if correct_numbers == True:
            if int(np.sum(charge_states))!=number_of_atoms: # if the total number does not equal the number of atoms for the particular atom add the difference 
                diff = number_of_atoms-int(np.sum(charge_states))
                indx = np.where(np.max(charge_states)==charge_states)
                charge_states[indx[0][0]] +=diff
        for i in range(number_of_charge_states):
            f.writelines(str(np.abs(charge_states[i])) + " ")     
        f.writelines("\n")
    f.close()


def write_atom_data_to_file_new(output_path, time_resolved_data, atom, ynf):
    """ Write to a file the number of atoms for each charge state as a function of time (done for a specific atomic species). """

    if ynf == True:
        f = open(output_path + "/" + atom + "_ynf.txt", "w")
    else:
        f = open(output_path + "/" + atom + ".txt", "w")
    steps = (np.shape(time_resolved_data)[0])
    number_of_charge_states = (np.shape(time_resolved_data)[1])
   
    for t in range(steps):
        #for i in range(number_of_charge_states-1, -1, -1):
        for i in range(number_of_charge_states):
            f.writelines(str(time_resolved_data[t][i]) + " ")     
        f.writelines("\n")
  
    f.close()

def write_atom_file_t(output_path, time_resolved_data, atom, number_of_atoms):
    """ Write to a file the number of atoms for each charge state as a function of time (done for a specific atomic species).
		This is done for each time-step.  """

    number_of_charge_states = (np.shape(time_resolved_data)[0])
    steps = (np.shape(time_resolved_data)[1])
    print(number_of_charge_states)
   # exit(0)
    #for t in range(len(time)):
    for t in range(steps):
		#if t == 5:
		#	break
		f = open(output_path + "/" + atom + "_{0}.txt".format(t), "w")
		charge_states = []
		for i in range(number_of_charge_states-1, -1, -1):
		    data = np.rint(number_of_atoms*time_resolved_data[i][t])
		    charge_states.append(data)
		correct_numbers = True
		if correct_numbers == True:
		    if int(np.sum(charge_states))!=number_of_atoms: # if the total number does not equal the number of atoms for the particular atom add the difference 
				diff = number_of_atoms-int(np.sum(charge_states))
				indx = np.where(np.max(charge_states)==charge_states)

				print("Corrected with amount: {0}".format(diff))
				charge_states[indx[0][0]] +=diff

		for i in range(number_of_charge_states):
		    f.writelines(str(np.abs(charge_states[i])) + " ")     
		f.writelines("\n")
		f.close()


def create_folder(simulation_path):
    try:
        os.mkdir(simulation_path)
    except:
        print(simulation_path)
        os.system("rm -rf + " + simulation_path)
        os.mkdir(simulation_path)

def calculate_debye_length(tev, ne):
    """ Calculates the Debye length in ångström from the free electron temperature and density. """
    time_resolved_debye_length = []
    time_resolved_plasma_parameter = []
    for i in range(np.shape(tev)[0]):
        #print(i)
        #print(np.mean(tev[i]),np.mean(ne[i]))
        mean_tev = np.mean(tev[i])
        mean_ne = np.mean(ne[i])
        ev_to_kelvin = 11604.5250061657
        electron_temp = ev_to_kelvin*mean_tev # in kelvin
        free_electron_density = (1/0.01)**3*mean_ne
        debye_shielding = 1e10*69*np.sqrt(electron_temp/free_electron_density)
        debye_shielding = debye_shielding*0.1 # to nanometer
        plasma = (4*np.pi*free_electron_density*debye_shielding**1)/3
        time_resolved_debye_length.append(debye_shielding)
        time_resolved_plasma_parameter.append(plasma)
    return time_resolved_debye_length, time_resolved_plasma_parameter

def check_output(atom, number_of_atoms):
  #  f = open("./1e+18/IONIZATION_DATA/{}.txt".format(atom))
    f = open(run_data_path + "{}.txt".format(atom))
    lines = f.readlines()
    for i, line in enumerate(lines):
        data = line.split()
        #print(data)
        x=[float(i) for i in line.split()]
        if float(np.sum(x))!=float(number_of_atoms):
            print(np.sum(x), number_of_atoms, i , x)
            print("Something is wrong for {}".format(atom))
            exit(0)

    print("Charge data seems right for {}".format(atom))

def check_output_ynf(atom, number_of_atoms):
  #  f = open("./1e+18/IONIZATION_DATA/{}.txt".format(atom))
    f = open(run_data_path + "{}_ynf.txt".format(atom))
    lines = f.readlines()
    for i, line in enumerate(lines):
        data = line.split()
        #print(data)
        x=[float(i) for i in line.split()]
        if int(np.sum(x))!=number_of_atoms:
            print(np.sum(x), number_of_atoms, i , x)
            print("Something is wrong for ynf {}".format(atom))
            exit(0)

    print("Charge data seems right for ynf: {}".format(atom))

def write_debye_length_files(path_to_data):
	time, tev, ne = get_electron_data(path_to_data)
	time_resolved_debye_length, time_resolved_plasma_parameter = calculate_debye_length(tev, ne)

	debye = time_resolved_debye_length

	indx = 0
	for k, data in enumerate(debye):
		if debye[k] > debye[k+1]:
		    print(debye[k], time[k])
		    indx = k
		    break
	 
	new_debye = []
	new_time = []
	new_debye.append(10)
	new_time.append(0)
	for v, val in enumerate(debye):
		if v > k:
		    new_debye.append(val)
		    new_time.append(time[v])

	f2 = interp1d(new_time, new_debye, kind='cubic')
	times = np.linspace(np.min(new_time), np.max(new_time), 1000)

	plot_debye = False
	if plot_debye == True:
		#plt.plot(new_time, new_debye)
		#plt.plot(times, f2(times), "--")
		plt.plot(np.multiply(time,1e15), f2(time), "--")
		plt.plot(np.multiply(time,1e15),debye, "r")
		plt.xlim(0,5)
		plt.xlabel("time (fs)")
		plt.ylabel("Debye length")
		plt.show()

	interpolated_debye = f2(time)

	fle = open(charge_output_path + "/debye_shielding_interpolated.txt", "w")
	for datapoint in interpolated_debye:
		fle.write(str(datapoint) + "\n")
	fle.close()

	for j, datapoint in enumerate(interpolated_debye):
		fle = open(charge_output_path + "/debye_shielding_interpolated_{0}.txt".format(j), "w")
		fle.write(str(datapoint) + "\n")
		fle.close()

## END OF FUNCTIONS ##

path_to_PDB = "./sphere_829806_relaxed.pdb"
basepath = os.getcwd() 
simulation_path = basepath + "/" + RUN#"/simulation"
create_folder(simulation_path)
create_folder(basepath + "/IONIZATION_DATA")
charge_output_path = simulation_path + "/IONIZATION_DATA"
run_data_path = basepath + "/IONIZATION_DATA/"
path_to_data = "/home/ibrahim/projects/ice/2022-10-03/previous_ice_simulations/SIMULATIONS/75fs_ice_multiple_intensities_ener8000/fwhm-50/fl-{0}/run_ice.plots/".format(RUN) # cretin data path	

try:
    os.mkdir(charge_output_path)
except:
    os.chdir(simulation_path)
    os.system("rm -rf IONIZATION_DATA")
    os.mkdir(charge_output_path)
    os.chdir(basepath)

configs = get_configs("oxygen", path_to_data)
#configs = reverse_config(path_to_data)
atoms, atom_indices = get_atom_info(path_to_PDB)
atom_number_O = 8
atom_number_H = 1
write_debye_length_files(path_to_data)

print(configs)
print(atom_indices[1:5])
print(atoms[1:5])
print(atom_indices[0:10])
print(atoms[0:10])

## RUN STARTS HERE ##

def create_damage_data(step, i):
	#step = 7000
	#print("Running step: {}".format(step))

	hydrogen_charge_states = np.zeros(hydrogens)
	oxygen_charge_states = np.zeros(oxygens)
	np.random.seed(42)
	#for step in range(nsteps):
	TIMESTEP = step
	f = open("./charge_data/outfile_test_{}.txt".format(step), "w")
	#time_resolved_charge_state_H[step] = np.rint(hydrogens*time_resolved_charge_state_H[step])
	#time_resolved_charge_state_O[step] = np.rint(oxygens*time_resolved_charge_state_O[step])

	time_resolved_charge_state_H[TIMESTEP] = np.rint(hydrogens*time_resolved_charge_state_H[TIMESTEP])
	time_resolved_charge_state_O[TIMESTEP] = np.rint(oxygens*time_resolved_charge_state_O[TIMESTEP])

	if int(np.sum(time_resolved_charge_state_O[TIMESTEP]))!=oxygens: # if the total number does not equal the number of atoms for the particular atom add the difference 
		diff = oxygens-int(np.sum(time_resolved_charge_state_O[TIMESTEP]))
		indx = np.where(np.max(time_resolved_charge_state_O[TIMESTEP])==time_resolved_charge_state_O[TIMESTEP])
		print("Corrected oxygen with amount: {0}".format(diff))
		time_resolved_charge_state_O[TIMESTEP][indx[0][0]] +=diff

	if int(np.sum(time_resolved_charge_state_H[TIMESTEP]))!=hydrogens: # if the total number does not equal the number of atoms for the particular atom add the difference 
		diff = hydrogens-int(np.sum(time_resolved_charge_state_H[TIMESTEP]))
		indx = np.where(np.max(time_resolved_charge_state_H[TIMESTEP])==time_resolved_charge_state_H[TIMESTEP])
		print("Corrected hydrogen with amount: {0}".format(diff))
		time_resolved_charge_state_H[TIMESTEP][indx[0][0]] +=diff

	test = np.zeros(4)
	#test[0:2] = 1
	#print(test)

	def assign_charges(time_resolved_charge_state_array, number_of_atoms, atm):
		#print("Total number of atoms of atom: {0} is {1}. ".format(atm, number_of_atoms))

		charge_state_array = np.zeros(number_of_atoms)		
		total_atoms = 0

		for i in range(len(time_resolved_charge_state_array)):
			if total_atoms == number_of_atoms:
				break
			if i == 0:
				total_atoms += int(time_resolved_charge_state_array[i])
				charge_state_array[0:int(time_resolved_charge_state_array[i])] = i
			else:
				indx1 = 0
				indx2 = 0
				for k in range(i):
					indx1 += int(time_resolved_charge_state_array[k])
					indx2 += int(time_resolved_charge_state_array[k])

				indx2 += int(time_resolved_charge_state_array[i])
				charge_state_array[indx1:indx2] = i

		check_states = np.zeros(len(time_resolved_charge_state_array))
		for val in charge_state_array:
			check_states[int(val)]+=1
	
		for value1, value2 in zip(time_resolved_charge_state_array, check_states):
			if value1 != value2:	
				print(value1, value2)
				print("Check states and timeresolved charge shate not equal!")
				exit(0)
		#print(check_states)
		#print(time_resolved_charge_state_array)

		return charge_state_array


	oxygen_charge_states = assign_charges(time_resolved_charge_state_O[TIMESTEP], oxygens, "oxygen")
	hydrogen_charge_states = assign_charges(time_resolved_charge_state_H[TIMESTEP], hydrogens, "hydrogen")
	#print(oxygen_charge_states)
	#print(hydrogen_charge_states)


	np.random.shuffle(oxygen_charge_states)
	np.random.shuffle(hydrogen_charge_states)

	#print(oxygen_charge_states)
	#print(hydrogen_charge_states)
	
	txt_string = ""	

	oxygen_indx = 0
	hydrogen_indx = 0

	for atm in atoms:
		if atm == "O":
			txt_string += str(oxygen_charge_states[oxygen_indx]) + "\n"
			oxygen_indx+=1
		if atm == "H":
			txt_string += str(hydrogen_charge_states[hydrogen_indx]) + "\n"
			hydrogen_indx+=1
	f.writelines(txt_string)
	
oxygens, nitrogens, carbons, zincs, sulfurs, hydrogens = get_number_of_atoms(path_to_PDB)
print("Number of atoms = O: {0}, N: {1}, C: {2}, ZN: {3}, S: {4}, H: {5}.".format(oxygens, nitrogens, carbons, zincs, sulfurs, hydrogens))

time_interpolated, time_resolved_charge_state_O, configs = get_atom_data_yisofrac("oxygen", path_to_data, False)
time_interpolated, time_resolved_charge_state_H, configs = get_atom_data_yisofrac("hydrogen", path_to_data, False)

time_resolved_charge_state_H = np.transpose(time_resolved_charge_state_H)
time_resolved_charge_state_O = np.transpose(time_resolved_charge_state_O)

nsteps = np.shape(time_resolved_charge_state_O)[0]
nsteps = 5001
Parallel(n_jobs=30, prefer="threads")(delayed(create_damage_data)(step, step) for step in range(nsteps))
os.system("cp " + charge_output_path+"/debye_shielding_interpolated* " +  run_data_path) 















































exit(0)
previous = False
if previous == True:
	for state in range(nstates):
		net_charge = state
		if time_resolved_charge_state_O[step][state]>0:
			for atm in atoms:
				#print(atm)
				if atm == "O":
					#print(atm)
					#print(time_resolved_charge_state_O[step][state])
					f.writelines(atm + " " + str(net_charge) + "\n")
					time_resolved_charge_state_O[step][state]-=1
					#print(time_resolved_charge_state_O[step][state])
				if atm == "H":
					f.writelines(atm + " " + str(net_charge) + "\n")
					time_resolved_charge_state_H[step][state]-=1
				
f.close()


exit(0)
for timestep in range(np.shape(time_resolved_charge_state_O)[1]):
	print(time_resolved_charge_state_O[:][timestep])
	exit(0)

exit(0)
write_atom_file(charge_output_path, time_resolved_charge_state_O, "oxygen", oxygens)
write_atom_file(charge_output_path, time_resolved_charge_state_H, "hydrogen",hydrogens)
write_atom_file_t(charge_output_path, time_resolved_charge_state_O, "oxygen",oxygens)
write_atom_file_t(charge_output_path, time_resolved_charge_state_H, "hydrogen",hydrogens)

os.system("cp " + charge_output_path+"/oxygen* " +  run_data_path ) 
os.system("cp " + charge_output_path+"/hydrogen* " +  run_data_path ) 
os.system("cp " + charge_output_path+"/debye_shielding_interpolated* " +  run_data_path ) 
check_output("oxygen",oxygens)
check_output("hydrogen",hydrogens)


















