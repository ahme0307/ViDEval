# A Matlab GUI for subjective video evaluation
A simple matlab gui to perform subjective experiment for rating two videos. The videos are played in sequence in random order from "Orig"
and "TSR" folder. 

The output is written on a text file 

>Data.txt

with the following format

| Folder | Video | Coin | randlist | Score | Appear | Clock | Name | Email |
| --- | --- |  --- |---      | ---    |   ---  | ---   |---  | --- |
| ./Original |  P2E7_cut.avi |  1 |  3 |  Second |  5 |  Fred |  fred@gmail.com |  2019.6.26.12.1.9 | 

## Functionality

Supports rating only two videos. It is not possible to go back once a pair of video is rated. 

- Play Video 1
- Play Video 2
- Replay
- Rate
- Back



## Screenshots
![alt text](https://github.com/ahme0307/ViDEval/blob/master/readme/image1.png)
![alt text](https://github.com/ahme0307/ViDEval/blob/master/readme/video2.PNG)
![alt text](https://github.com/ahme0307/ViDEval/blob/master/readme/result.PNG)

## Reference
If you find this code useful please cite 

>Mohammed, Ahmed, Ivar Farup, Marius Pedersen, Øistein Hovde, and Sule Yildirim Yayilgan. "Stochastic capsule endoscopy image enhancement." Journal of Imaging 4, no. 6 (2018): 75.


@article{mohammed2018stochastic,
  title={Stochastic capsule endoscopy image enhancement},
  author={Mohammed, Ahmed and Farup, Ivar and Pedersen, Marius and Hovde, {\O}istein and Yildirim Yayilgan, Sule},
  journal={Journal of Imaging},
  volume={4},
  number={6},
  pages={75},
  year={2018},
  publisher={Multidisciplinary Digital Publishing Institute}
}

