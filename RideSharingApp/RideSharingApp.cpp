#include <iostream>
#include <vector>
#include <string>
#include <iomanip>
using namespace std;

// ----- Base Class -----
class Ride {
protected:
    string rideID, pickupLocation, dropoffLocation;
    double distance;

public:
    Ride(string id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    virtual double fare() const = 0;
    virtual string rideType() const = 0;

    virtual void rideDetailsForDriver() const {
        cout << "Ride ID: " << rideID
             << " | Type: " << rideType()
             << " | From: " << pickupLocation
             << " To: " << dropoffLocation
             << " | Distance: " << distance << " miles"
             << " | Fare: $" << fixed << setprecision(2) << fare() << endl;
    }

    virtual void rideDetailsForRider() const {
        cout << "Ride ID: " << rideID
             << " | From: " << pickupLocation
             << " To: " << dropoffLocation
             << " | Distance: " << distance << " miles"
             << " | Fare: $" << fixed << setprecision(2) << fare() << endl;
    }

    virtual ~Ride() {}
};

// ----- Subclass: Standard Ride -----
class StandardRide : public Ride {
public:
    StandardRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 1.5;
    }

    string rideType() const override {
        return "Standard";
    }
};

// ----- Subclass: Premium Ride -----
class PremiumRide : public Ride {
public:
    PremiumRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 3.0 + 5.0; // base fee
    }

    string rideType() const override {
        return "Premium";
    }
};

// ----- Driver Class -----
class Driver {
private:
    string driverID, name;
    int rating;  // stored as int for simplicity
    vector<Ride*> assignedRides;

public:
    Driver(string id, string n, int r) : driverID(id), name(n), rating(r) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void displayDriverInfo() const {
        cout << "\n========== DRIVER INFORMATION ==========\n";
        cout << "Driver Name: " << name
             << " | ID: " << driverID
             << " | Rating: " << rating
             << " | Total Rides: " << assignedRides.size() << endl;

        cout << "--- Rides Completed by Driver ---\n";
        for (const auto& ride : assignedRides) {
            ride->rideDetailsForDriver();
        }
    }
};

// ----- Rider Class -----
class Rider {
private:
    string riderID, name;
    vector<Ride*> requestedRides;

public:
    Rider(string id, string n) : riderID(id), name(n) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }

    void displayRiderInfo() const {
        cout << "\n========== RIDER INFORMATION ==========\n";
        cout << "Rider Name: " << name
             << " | ID: " << riderID
             << " | Total Requested Rides: " << requestedRides.size() << endl;

        cout << "--- Ride History for Rider ---\n";
        for (const auto& ride : requestedRides) {
            ride->rideDetailsForRider();
        }
    }
};

// ----- Main -----
int main() {
    // Creating Rides
    StandardRide* ride1 = new StandardRide("R101", "DFW Airport", "Dallas Downtown", 10);
    PremiumRide* ride2 = new PremiumRide("R102", "Galleria Mall", "Ft Worth Center", 30);

    // Creating Users
    Driver driver("D001", "Manus", 4);
    Rider rider("R001", "Nishan");

    // Assign rides
    driver.addRide(ride1);
    driver.addRide(ride2);

    rider.requestRide(ride1);
    rider.requestRide(ride2);

    // Display Info
    rider.displayRiderInfo();
    driver.displayDriverInfo();

    // Clean up
    delete ride1;
    delete ride2;

    return 0;
}
