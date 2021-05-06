
def pcm(conf):
	with open(conf.hf, "r") as f:
		data = [x.split() for x in f.readlines()]
		lon = [x[0] for x in data]
		lat = [x[1] for x in data]
		hf = [x[2] for x in data]
	
	return


if __name__ == "__main__":
	from config import Config
	conf = Config()
	pcm(conf)
