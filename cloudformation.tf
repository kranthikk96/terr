Description: >
    This template is design to deploy EC2 instance in AWS enviornment.
Parameters:
  EnvironmentName:
    Description: An environment name that will be prefixed to resource names
    Type: String
    Default: PROD
  VpcId:
    Description: VPC ID for resources
    Type: AWS::SSM::Parameter::Value<AWS::EC2::VPC>
    Default: VpcID
  KeyName:
    Description: Name of an existing EC2 KeyPair to enable RDP access to the instance
    Type: AWS::SSM::Parameter::Value<AWS::EC2::KeyPair::KeyName>
    ConstraintDescription: must be the name of an existing EC2 KeyPair
    Default: KeyName
  InstanceType:
    Description: App EC2 instance type
    Type: AWS::SSM::Parameter::Value<String>
    Default: InstanceType
  SubnetID:
    Description: App EC2 instance type
    Type: AWS::SSM::Parameter::Value<AWS::EC2::Subnet>
    Default: SubnetID
  ImageID:
    Description: App EC2 instance type
    Type: AWS::SSM::Parameter::Value<AWS::EC2::Image::ID>
    Default: ImageID
Resources:
  EC2Instance1:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType:
        Ref: InstanceType
      KeyName:
        Ref: KeyName
      DisableApiTermination: true
      ImageId: !Ref ImageID
      SubnetId: !Ref SubnetID
      SecurityGroupIds:
        - sg-0d86e1f034bca868c
      BlockDeviceMappings:
        -
          DeviceName: /dev/sda1
          Ebs:
            VolumeSize: 80
        -
          DeviceName: /dev/xvdf
          Ebs:
            VolumeSize: 80
      Tags:
        - Key: Product
          Value: test
        - Key: Type
          Value: AppServer
