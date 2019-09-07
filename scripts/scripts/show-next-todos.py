#!/bin/env python

from random import shuffle
from os import system

def extract_by_tag(lines, tag):
    i = 0
    while not lines[i] == "%% " + tag + " %%":
        i = i+1
        if i >= len(lines):
            break

    j = i+1
    while not lines[j].startswith("%%"):
        j = j+1
        if j >= len(lines):
            break

    return lines[i+1:j]


lines = []
with open("/home/auroden/todo.txt", "r") as file:
    content = file.read()

    for line in content.split("\n"):
        if not line.startswith("#") and line != "":
            lines.append(line)

with_dl = extract_by_tag(lines, "deadline")
without_dl = extract_by_tag(lines, "random")
shuffle(without_dl)

output = "\n".join(with_dl[0:3]) + "\nRandom:\n" + "\n".join(without_dl[0:2])
system("""notify-send "TODO" "{}" """.format(output))

