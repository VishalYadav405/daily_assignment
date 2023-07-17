#!/bin/bash


shuffle_array() {
    local array=("$@") 
    local n=${#array[@]}
    local shuffled_array=("${array[@]}")

    for ((i = 0; i < n; i++)); do
        j=$((RANDOM % n))

        local temp=${shuffled_array[i]}
        shuffled_array[i]=${shuffled_array[j]}
        shuffled_array[j]=$temp
    done

    echo "${shuffled_array[@]}"
}


read total_time
#total_time=30
total_time_sec=$((total_time * 60))
songs_size=()


while [ $total_time_sec -gt 0 ]; do
	song=$((RANDOM % total_time_sec + 1))
	songs_size+=($song)
	total_time_sec=$((total_time_sec - song))
done

suffled_song=($(shuffle_array "${songs_size[@]}"))


#for element in "${suffled_song[@]}"; do
#    echo "$element"
#done

rm -rf playlist
mkdir playlist

for song in "${suffled_song[@]}"
do
	minutes=$((song / 60))
	seconds=$((song % 60))

	file_name=${minutes}_${seconds}.mp3
	
	touch "./playlist/$file_name"
	
#	echo "$file_name created" 
done
