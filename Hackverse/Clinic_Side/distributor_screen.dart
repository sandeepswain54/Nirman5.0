import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  // Ayurvedic colors
  final Color _primaryColor = Color(0xFF2E7D32); // Deep green
  final Color _secondaryColor = Color(0xFF8BC34A); // Light green
  final Color _accentColor = Color(0xFF795548); // Earth brown
  final Color _backgroundColor = Color(0xFFF5F5DC); // Beige background
  final Color _cardColor = Color(0xFFFFFDE7); // Light yellow
  final Color _textColor = Color(0xFF5D4037); // Dark brown

  bool isOnline = true;
  late TabController _tabController;
  int _currentTabIndex = 0;

  final List<String> _tabTitles = [
    'Today\'s Sessions',
    'Upcoming Bookings',
    'Payments Due',
    'Patient Records',
    'Medicine Stock',
    'Waitlist',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          // ===== Top Bar =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _secondaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.spa, color: Colors.white, size: 1),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ayurvedic Wellness Clinic",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Dr. Sharma's Panchakarma Center",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isOnline ? Colors.green : Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isOnline ? Colors.green : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isOnline ? "Clinic Open" : "Clinic Closed",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Switch(
                          value: isOnline,
                          onChanged: (value) {
                            setState(() {
                              isOnline = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // ===== Clinic Summary =====
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Clinic Overview",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Complete clinic operations at a glance",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== Tab Bar =====
          Container(
            color: _cardColor,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: _primaryColor,
              unselectedLabelColor: _textColor.withOpacity(0.6),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _primaryColor.withOpacity(0.1),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),

          // ===== Tab Content =====
          Expanded(
            child: Container(
              color: _backgroundColor,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Today's Sessions Tab
                  _buildTodaysSessionsTab(),
                  // Upcoming Bookings Tab
                  _buildUpcomingBookingsTab(),
                  // Payments Due Tab
                  _buildPaymentsDueTab(),
                  // Patient Records Tab
                  _buildPatientRecordsTab(),
                  // Medicine Stock Tab
                  _buildMedicineStockTab(),
                  // Waitlist Tab
                  _buildWaitlistTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Today's Sessions Tab =====
  Widget _buildTodaysSessionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Overview Cards
          Row(
            children: [
              Expanded(
                child: _ayurvedicMetricCard(
                  "Scheduled Today",
                  "12",
                  _primaryColor,
                  Icons.calendar_today,
                  "Patients",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ayurvedicMetricCard(
                  "Completed",
                  "8",
                  Colors.green,
                  Icons.check_circle,
                  "Sessions",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ayurvedicMetricCard(
                  "Ongoing",
                  "3",
                  Colors.orange,
                  Icons.access_time,
                  "Therapies",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ayurvedicMetricCard(
                  "Cancelled",
                  "1",
                  Colors.red,
                  Icons.cancel,
                  "Today",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            "Today's Therapy Sessions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildSessionsList(),
        ],
      ),
    );
  }

  // ===== Upcoming Bookings Tab =====
  Widget _buildUpcomingBookingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking Stats
          Row(
            children: [
              Expanded(
                child: _therapyStatCard("Panchakarma", "5", _primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _therapyStatCard("Abhyanga", "8", _secondaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _therapyStatCard("Shirodhara", "3", _accentColor),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            "Upcoming Appointments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildAppointmentsList(),
        ],
      ),
    );
  }

  // ===== Payments Due Tab =====
  Widget _buildPaymentsDueTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ayurvedicAmountCard("Total Receivables", "₹45,670", _primaryColor, Icons.payments),
          const SizedBox(height: 16),
          _ayurvedicAmountCard("Overdue Payments", "₹12,340", Colors.orange, Icons.warning),
          const SizedBox(height: 16),
          _ayurvedicAmountCard("Expected Today", "₹8,900", Colors.green, Icons.today),

          const SizedBox(height: 24),
          Text(
            "Pending Payments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildPaymentsList(),
        ],
      ),
    );
  }

  // ===== Patient Records Tab =====
  Widget _buildPatientRecordsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _recordStatCard("Total Patients", "156", _primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _recordStatCard("New This Month", "23", _secondaryColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _recordStatCard("Follow-ups Due", "12", Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _recordStatCard("Dosha Analysis", "45", Colors.purple),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            "Recent Patient Visits",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildPatientVisitsList(),
        ],
      ),
    );
  }

  // ===== Medicine Stock Tab =====
  Widget _buildMedicineStockTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stockAlertCard("Critical Stock", "8 herbs", Colors.red, Icons.warning),
          const SizedBox(height: 16),
          _stockAlertCard("Low Stock", "15 oils", Colors.orange, Icons.inventory),
          const SizedBox(height: 16),
          _stockAlertCard("Out of Stock", "3 powders", Colors.purple, Icons.block),

          const SizedBox(height: 24),
          Text(
            "Herbal Medicine Inventory",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildMedicineList(),
        ],
      ),
    );
  }

  // ===== Waitlist Tab =====
  Widget _buildWaitlistTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _waitlistCard("Today's Waitlist", "5 patients", "2 hours avg", _primaryColor),
          const SizedBox(height: 16),
          _waitlistCard("Therapy Waitlist", "8 sessions", "Panchakarma", _secondaryColor),
          const SizedBox(height: 16),
          _waitlistCard("Consultation", "3 patients", "Dr. Sharma", _accentColor),

          const SizedBox(height: 24),
          Text(
            "Current Waitlist",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 12),
          _buildWaitlistList(),
        ],
      ),
    );
  }

  // ===== Ayurvedic Reusable Widgets =====
  Widget _ayurvedicMetricCard(String title, String value, Color color, IconData icon, String unit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                unit,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: _textColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _therapyStatCard(String therapy, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            therapy,
            style: TextStyle(
              color: _textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _ayurvedicAmountCard(String title, String amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recordStatCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: _textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _stockAlertCard(String level, String count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              level,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _waitlistCard(String type, String count, String info, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                info,
                style: TextStyle(
                  color: _textColor.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== Ayurvedic List Builders =====
  Widget _buildSessionsList() {
    final sessions = [
      {'patient': 'Rajesh Kumar', 'therapy': 'Abhyanga Massage', 'time': '10:00 AM', 'status': 'Completed'},
      {'patient': 'Priya Sharma', 'therapy': 'Shirodhara', 'time': '11:30 AM', 'status': 'Ongoing'},
      {'patient': 'Amit Patel', 'therapy': 'Panchakarma', 'time': '2:00 PM', 'status': 'Scheduled'},
      {'patient': 'Sneha Reddy', 'therapy': 'Kati Basti', 'time': '4:00 PM', 'status': 'Scheduled'},
    ];

    return Column(
      children: sessions.map((session) => _ayurvedicListItem(
        title: session['patient']!,
        subtitle: session['therapy']!,
        trailing: session['time']!,
        status: session['status']!,
        color: session['status'] == 'Completed' ? Colors.green : 
               session['status'] == 'Ongoing' ? Colors.orange : _primaryColor,
      )).toList(),
    );
  }

  Widget _buildAppointmentsList() {
    final appointments = [
      {'patient': 'Vikram Singh', 'therapy': 'Panchakarma', 'date': 'Tomorrow, 10 AM'},
      {'patient': 'Anita Desai', 'therapy': 'Abhyanga', 'date': 'Dec 15, 11 AM'},
      {'patient': 'Rohit Mehta', 'therapy': 'Consultation', 'date': 'Dec 16, 3 PM'},
    ];

    return Column(
      children: appointments.map((appt) => _ayurvedicListItem(
        title: appt['patient']!,
        subtitle: appt['therapy']!,
        trailing: appt['date']!,
        status: 'Confirmed',
        color: _primaryColor,
      )).toList(),
    );
  }

  Widget _buildPaymentsList() {
    final payments = [
      {'patient': 'Deepak Joshi', 'amount': '₹2,500', 'due': 'Panchakarma Session'},
      {'patient': 'Meera Iyer', 'amount': '₹1,200', 'due': 'Abhyanga Therapy'},
      {'patient': 'Kiran Nair', 'amount': '₹3,000', 'due': 'Shirodhara Package'},
    ];

    return Column(
      children: payments.map((payment) => _ayurvedicListItem(
        title: payment['patient']!,
        subtitle: payment['due']!,
        trailing: payment['amount']!,
        status: 'Due',
        color: Colors.orange,
      )).toList(),
    );
  }

  Widget _buildPatientVisitsList() {
    final visits = [
      {'patient': 'Sanjay Gupta', 'purpose': 'Dosha Analysis', 'date': 'Today'},
      {'patient': 'Lata Menon', 'purpose': 'Follow-up', 'date': 'Yesterday'},
      {'patient': 'Arun Kumar', 'purpose': 'New Consultation', 'date': '2 days ago'},
    ];

    return Column(
      children: visits.map((visit) => _ayurvedicListItem(
        title: visit['patient']!,
        subtitle: visit['purpose']!,
        trailing: visit['date']!,
        status: 'Completed',
        color: Colors.green,
      )).toList(),
    );
  }

  Widget _buildMedicineList() {
    final medicines = [
      {'medicine': 'Ashwagandha Powder', 'stock': '200 gm left', 'status': 'Low Stock'},
      {'medicine': 'Brahmi Oil', 'stock': '50 ml left', 'status': 'Critical'},
      {'medicine': 'Triphala Churna', 'stock': 'Out of Stock', 'status': 'Reorder'},
    ];

    return Column(
      children: medicines.map((medicine) => _ayurvedicListItem(
        title: medicine['medicine']!,
        subtitle: medicine['stock']!,
        trailing: medicine['status']!,
        status: medicine['status']!,
        color: medicine['status'] == 'Critical' ? Colors.red : 
               medicine['status'] == 'Low Stock' ? Colors.orange : Colors.purple,
      )).toList(),
    );
  }

  Widget _buildWaitlistList() {
    final waitlist = [
      {'patient': 'Neha Sharma', 'therapy': 'Consultation', 'wait': '30 mins'},
      {'patient': 'Rahul Verma', 'therapy': 'Abhyanga', 'wait': '1 hour'},
      {'patient': 'Pooja Patel', 'therapy': 'Panchakarma', 'wait': '45 mins'},
    ];

    return Column(
      children: waitlist.map((item) => _ayurvedicListItem(
        title: item['patient']!,
        subtitle: item['therapy']!,
        trailing: item['wait']!,
        status: 'Waiting',
        color: _secondaryColor,
      )).toList(),
    );
  }

  Widget _ayurvedicListItem({
    required String title,
    required String subtitle,
    required String trailing,
    required String status,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _textColor.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                trailing,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                status,
                style: TextStyle(
                  color: _textColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}