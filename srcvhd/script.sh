#!/bin/bash

## source ../confmodelsim/config 

## nettoyage
if [ -d ../libs/LIB_oven ] 
then /bin/rm -rf ../libs/LIB_oven 
fi	

## creation de la librairie de travail
vlib ../libs/LIB_oven

## compilation
vcom -work LIB_oven automaton.vhd -cover fbs
vcom -work LIB_oven counter.vhd -cover fbs
vcom -work LIB_oven oven.vhd -cover fbs

