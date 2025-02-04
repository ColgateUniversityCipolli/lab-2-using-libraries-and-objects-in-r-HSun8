##TASK 1, STEP 1
# find command to find subdirectories of music
(all.dirs = list.dirs("Music", recursive=TRUE))

##TASK 1, STEP 2 
# use str_count() to count all / in each directory
# can sort into artist (count = 1) or album (count = 2)
counts.fslash = str_count(all.dirs, pattern ="/")
#print(counts)
album.dirs <- all.dirs[which(counts.fslash == 2)]

##TASK 1, STEP 3
#test case
# test.album <- album.dirs[1]
# #find files in album
# (test.files = list.files(test.album))
# #find all songs in album
# counts.wav = str_count(test.files, pattern=".wav")
# song.dirs = test.files[which(counts.wav == 1)]
# 
# test.song = song.dirs[2]
# 
# #use paste() to add album subdirectory and current track title
# wav.file = paste(test.album, "/", test.song, sep = "")
# 
# #extract track name
# test.song.new = str_sub(test.song, start = 0, end = -5 )
# 
# #create.json
# part1 = str_split_i(test.song.new, "-", 2)
# part2 = str_split_i(test.song.new, "-", 3)
# part3 = str_split_i(test.album, "/", 3)
# json = paste(part3, ".json", sep = "")
# json.file = paste(part1, part2, json, sep = "-")
# 
# #paste everything together
# (final = paste("streaming_extractor_music.exe", wav.file, json.file, sep = " "))

#Step 3.3
code.to.process = c()

for (i in 1:length(album.dirs)){
  curr.album = album.dirs[i]
  #Step 3.1
  curr.files = list.files(curr.album)
  #Step 3.2
  counts.wav = str_count(curr.files, pattern=".wav")
  curr.songs = curr.files[which(counts.wav == 1)]
  
  for (j in 1:length(curr.songs)){
    curr.song = curr.songs[j]
    #Step 3.3.a
    wav.file = paste(curr.album, "/", curr.song, sep = "")
    #Step 3.3.b
    curr.song.new = str_sub(curr.song, start = 0, end = -5)
    #Step 3.3.c
    part1 = str_split_i(curr.song.new, "-", 2)
    part2 = str_split_i(curr.song.new, "-", 3)
    part3 = str_split_i(curr.album, "/", 3)
    json = paste(part3, ".json", sep = "")
    json.file = paste(part1, part2, json, sep = "-")
    #Step 3.3.d
    final = paste("streaming_extractor_music.exe", " ", '"', wav.file, '"', " ", '"', json.file, '"', sep = "")
    code.to.process = c(code.to.process, final)
  }
}
writeLines(code.to.process, "batfile.txt")

##TASK 2, STEP 1
(all.files = list.files())
song = all.files[11]
song.split = str_split_1(song, "-")
artist = song.split[1]
album = song.split[2]
track = str_sub(song.split[3], start = 0, end = -6)

#TASK 2, STEP 2
song.json = fromJSON(song)
#lowlevel
average.loudness = song.json$lowlevel$average_loudness
spectralenergy.mean = song.json$lowlevel$spectral_energy$mean
#rhythm
danceability = song.json$rhythm$danceability
bpm = song.json$rhythm$bpm
#tonal
key.key = song.json$tonal$key_key
key.scale = song.json$tonal$key_scale
#metadata
length = song.json$metadata$audio_properties$length
