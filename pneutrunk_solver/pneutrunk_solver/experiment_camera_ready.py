import rclpy
import socket
from rclpy.node import Node
import numpy as np
from geometry_msgs.msg import PoseStamped
from geometry_msgs.msg import Pose
from pneutrunk_msgs.msg import PneutrunkJointState
import re

class CameraReady(Node):

    effector = np.zeros(3)

    def __init__(self):
        super().__init__("experiment_camera_ready")
        self.publisher_ = self.create_publisher(PneutrunkJointState, '/pneutrunk/camera/ready',100)
        self.subscriber3_ = self.create_subscription(Pose, "/pneutrunk/desired_position/cmd", self.desired_position, 100)
        self.timer_ = self.create_timer(0.001, self.plc_receiver)
        self.get_logger().info("PLC listener started...")
        

    def plc_receiver(self):
        localIP = "192.168.1.47" #41 IP PC
        localPort = 12050
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        server_address = (localIP, localPort)
        sock.bind(server_address)
        data, addr = sock.recvfrom(1024)  
        q_udp = data.decode('utf-8')
        q_string = str(q_udp)        
        if q_string[0] == '1':
            self.get_logger().info("Camera ready")
            with open('positions.txt', 'a') as file:
                file.write(str(self.effector))
                file.write("\n")
        if q_string[0] == '0':
            self.get_logger().info("Camera not ready")
    
    def desired_position(self, msg):
        self.effector[0] = round(msg.position.x, 2)
        self.effector[1] = round(msg.position.y, 2)
        self.effector[2] = round(msg.position.z, 2)
        
def main(args=None):
    rclpy.init(args=args)
    node = CameraReady()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == "__main__":
    main()