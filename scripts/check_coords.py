#!/usr/bin/env python
# Finds all coordinates in old and new mei file, checks if any are missing
# Assumes that all coordinates are attributes of either <zone> or <laidoutelement> or <system>
# Usage: python check_coords.py old.mei new.mei

from bs4 import BeautifulSoup

def main(oldmei, newmei):
	old = BeautifulSoup(open(oldmei))
	new = BeautifulSoup(open(newmei))

	# get all nodes that contain coordinates
	old_nodes = []
	new_nodes = []
	old_nodes.extend(old.find_all("zone"))
	old_nodes.extend(old.find_all("system"))
	old_nodes.extend(old.find_all("laidoutelement"))
	new_nodes.extend(new.find_all("zone"))
	new_nodes.extend(new.find_all("system"))
	new_nodes.extend(new.find_all("laidoutelement"))

	# get all coordinates from nodes
	old_coords = set()
	new_coords = set()
	for node in old_nodes:
		if node.attrs.has_key('ulx'):
			old_coords.add((node.attrs['ulx'], node.attrs['uly'], node.attrs['lrx'], node.attrs['lry']))
	for node in new_nodes:
		if node.attrs.has_key('ulx'):
			new_coords.add((node.attrs['ulx'], node.attrs['uly'], node.attrs['lrx'], node.attrs['lry']))

	old_extra = old_coords.difference(new_coords)
	if old_extra:
		print "%s contains coordinates that %s does not:" % (oldmei, newmei)
		for coord in old_extra:
			print coord
		old_extra = old_coords.difference(new_coords)
	new_extra = new_coords.difference(old_coords)
	if new_extra:
		print "%s contains coordinates that %s does not:" % (newmei, oldmei)
		for coord in new_extra:
			print coord

if __name__ == "__main__":
	import sys
	if len(sys.argv) != 3:
		sys.exit("Usage: python check_coords.py old.mei new.mei")
	else:
		main(sys.argv[1], sys.argv[2])