Builds an image with hacking tools.  
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/jscdroiddev/jsc-hack-tools)

Since there is no UI, only command line tools are added.

To run:
```
docker run -it --name jsc-hack-toole jscdroiddev/jsc-hack-tools:latest bash
```
You can add `--rm` for a single use and delete the container on exit.

Note the image is 1.x Gb in size. As I add new utility it might grow even more. You might consider a VM with Kali or similar distro if you want a full set of tools.

Current tools are:

| Tool             | Description                                | Version     |
| :--------------- | :----------------------------------------: | ----------: |
| Nmap             | Network Mapper, to get info about a host   | 7.70        |
| sqlmap           | Penetration test tool, SQL injection       | 1.4.7       |
| John The Ripper  | Password cracker                           | 1.9.0-jumbo |
| Hydra            | Crack file or web-form password            | 8.8         |
| Nikto            | Web-Server scanner                         | 2.1.6       |
| Pad Buster       | Tool to automate padding oracle attack     | 0.3.3       |
| AirCrack-NG      | Assess and crack wifi                      | 1.5.2       |
| wpscan           | Scan and brute force WordPress             | 3.8.4       |
