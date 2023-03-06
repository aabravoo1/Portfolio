import socket
#UDP_IP_ESP1 = "192.168.1.189"   # The IP that is printed in the serial monitor from the ESP32
#UDP_IP_ESP1 = "192.168.30.62"  # HOTSPOT
UDP_IP_ESP1 = "192.168.0.101"   # RED ROUTER
#UDP_IP_ESP2 = "192.168.1.187"
#UDP_IP_ESP2 = "192.168.30.29"  # HOTSPOT
UDP_IP_ESP2 = "192.168.0.100"   # RED ROUTER


SHARED_UDP_PORT = 4210

sock_esp1 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # Internet  # UDP
sock_esp1.connect((UDP_IP_ESP1, SHARED_UDP_PORT))

sock_esp2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # Internet  # UDP
sock_esp2.connect((UDP_IP_ESP2, SHARED_UDP_PORT))
 huujm

def loop():
    arr0 = bytearray(200)
    while True:
        dat_esp1 = sock_esp1.recv(2048)
        dat_esp2 = sock_esp2.recv(2048)

        packet_bin_esp1 = bytearray(b'')
        packet_bin_esp2 = bytearray(b'')

        channel_esp1 = int(dat_esp1[0:3])
        channel_esp2 = int(dat_esp2[0:3])

        for i in range(200):
            dat_int_esp1 = int(dat_esp1[3:][i * 3:i * 3 + 3])
            dat_int_esp2 = int(dat_esp2[3:][i * 3:i * 3 + 3])
            packet_bin_esp1.append(dat_int_esp1)
            packet_bin_esp2.append(dat_int_esp2)

        #print("Channel ESP1: " + str(channel_esp1))
        #print(list(packet_bin_esp1))
        #print("Channel ESP2: " + str(channel_esp2))
        #print(list(packet_bin_esp2))

        if channel_esp1 == channel_esp2:
            sock_esp1.send(packet_bin_esp2)
            sock_esp2.send(packet_bin_esp1)
        else:
            sock_esp1.send(arr0)
            sock_esp2.send(arr0)



if _name_ == "_main_":
    print("init")
    sock_esp1.send('init_connection_esp1'.encode())
    sock_esp2.send('init_connection_esp2'.encode())
    loop()