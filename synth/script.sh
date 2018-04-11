#!/bin/bash

## source ../confmodelsim/config 

## nettoyage
if [ -d ../libs/LIB_oven_SYNTH ] 
then /bin/rm -rf ../libs/LIB_oven_SYNTH
fi

## creation de la librairie de travail
vlib ../libs/LIB_oven_SYNTH

## compilation

vcom -work LIB_oven_SYNTH automaton_binary.vhd -cover fbs
vcom -work LIB_oven_SYNTH automaton_onehot.vhd -cover fbs
vcom -work LIB_oven_SYNTH automaton_degray.vhd -cover fbs

