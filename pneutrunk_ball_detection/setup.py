from setuptools import find_packages, setup

package_name = 'pneutrunk_ball_detection'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='km',
    maintainer_email='ivan.virgala@tuke.sk',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            "publisher_node = pneutrunk_ball_detection.publisher_node:main",
            "subsrciber_node = pneutrunk_ball_detection.subsrciber_node:main"
        ],
    },
)
