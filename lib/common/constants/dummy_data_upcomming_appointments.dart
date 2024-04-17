List<Map<String, dynamic>> dummyAppointmentsData = [
  {'name': 'Aarav Kumar', 'date': '19/02', 'time': '10:00 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Ananya Gupta', 'date': '22/02', 'time': '04:15 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Aishwarya Reddy', 'date': '24/02', 'time': '01:00 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Anika Singh', 'date': '28/02', 'time': '03:20 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Aditi Sharma', 'date': '26/02', 'time': '09:45 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Shreya Kapoor', 'date': '02/03', 'time': '10:20 AM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Neha Sharma', 'date': '04/03', 'time': '05:30 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Vivek Verma', 'date': '23/03', 'time': '11:50 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Kavya Gupta', 'date': '06/03', 'time': '02:10 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Vishal Reddy', 'date': '09/03', 'time': '01:45 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Sheetal Kapoor', 'date': '26/03', 'time': '10:20 AM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Deepak Sharma', 'date': '11/03', 'time': '08:30 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': true},
  {'name': 'Meena Singh', 'date': '20/03', 'time': '01:30 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': true},
  {'name': 'Rekha Verma', 'date': '28/03', 'time': '04:45 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Madhu Sharma', 'date': '30/03', 'time': '11:15 AM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Rahul Kapoor', 'date': '01/04', 'time': '07:00 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Rohit Sharma', 'date': '03/04', 'time': '12:20 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Ritu Kapoor', 'date': '05/04', 'time': '08:15 AM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Vinod Singh', 'date': '25/03', 'time': '06:40 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Suman Gupta', 'date': '14/03', 'time': '11:00 AM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Ravi Patel', 'date': '16/03', 'time': '07:10 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Rakesh Gupta', 'date': '18/03', 'time': '02:15 PM', 'rx_status': 'not sold', 'priority': true},
  {'name': 'Advik Sharma', 'date': '21/02', 'time': '02:45 PM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Advait Patel', 'date': '23/02', 'time': '08:20 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Arjun Kumar', 'date': '25/02', 'time': '06:30 PM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Abhinav Verma', 'date': '27/02', 'time': '11:10 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Aaradhya Singh', 'date': '20/02', 'time': '11:30 AM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Rohan Mishra', 'date': '01/03', 'time': '07:45 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Kiran Singhania', 'date': '03/03', 'time': '12:15 PM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Raj Kapoor', 'date': '05/03', 'time': '09:00 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Rahul Malhotra', 'date': '07/03', 'time': '04:50 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Nisha Sharma', 'date': '08/03', 'time': '11:30 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Sonia Choudhary', 'date': '10/03', 'time': '06:15 PM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Priya Singh', 'date': '12/03', 'time': '03:40 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Gaurav Kapoor', 'date': '13/03', 'time': '09:20 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Rita Verma', 'date': '15/03', 'time': '04:20 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Pooja Malhotra', 'date': '17/03', 'time': '12:40 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Akash Reddy', 'date': '19/03', 'time': '08:05 AM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Sanjay Kumar', 'date': '21/03', 'time': '05:10 PM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Sangeeta Sharma', 'date': '22/03', 'time': '09:25 AM', 'rx_status': 'not sold', 'priority': false},
  {'name': 'Rina Malhotra', 'date': '24/03', 'time': '03:15 PM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Sunil Sharma', 'date': '27/03', 'time': '01:55 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Ajay Gupta', 'date': '29/03', 'time': '08:30 AM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Sonali Verma', 'date': '31/03', 'time': '02:40 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Riya Singh', 'date': '02/04', 'time': '09:45 AM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
  {'name': 'Neeraj Malhotra', 'date': '04/04', 'time': '04:30 PM', 'rx_status': 'sold', 'sold_status': 'transit', 'priority': false},
  {'name': 'Ravi Patel', 'date': '06/04', 'time': '11:10 AM', 'rx_status': 'sold', 'sold_status': 'delivered', 'priority': false},
];