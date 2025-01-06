# Terraform MOdular Approach

Creates following resources

**Network:**
- VPC ``cidr => 10.0.0.0/16``

- Two subnets
    - Public CIDR ``10.0.1.0/24``
    - Private CIDR ``10.0.2.0/24``

- Internet Gateway

- Public subnet Internet Facing

**Security Group:**

- Public Security Group
    - Ingress => Port => 22, 80 => (anywhere)
    - Egress => Any port => Any ip

- Private Security Group
    - Ingress => Port => 22 (from public subnet cidr)
    - Egress => Any port => Any ip

**EC2 Instances:**

- In public subnet with public SG.
- In private subnet with private SG.

Note that, the private instance wont have access to internet.

This requires a NAT gateway.

**NAT Gateway:**

Note that nat requires elastic ip.

- Create EIP.
- Create a NAT Gateway with EIP on public subnet.
- Create a Route Table on a Private Subnet.
- Packets from ``0000/0`` on private subnet is then routed to NAT gateway.
