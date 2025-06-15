"----- Ride Base Class -----"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance riderID driverID |

    Ride class >> newWithID: id pickup: pickup dropoff: drop distance: dist riderID: rID driverID: dID [
        ^ (self new)
            setRideID: id;
            setPickup: pickup;
            setDropoff: drop;
            setDistance: dist;
            setRiderID: rID;
            setDriverID: dID;
            yourself.
    ]

    setRideID: id [ rideID := id. ]
    setPickup: loc [ pickupLocation := loc. ]
    setDropoff: loc [ dropoffLocation := loc. ]
    setDistance: d [ distance := d. ]
    setRiderID: r [ riderID := r. ]
    setDriverID: d [ driverID := d. ]

    rideID [ ^ rideID ]
    pickupLocation [ ^ pickupLocation ]
    dropoffLocation [ ^ dropoffLocation ]
    distance [ ^ distance ]
    riderID [ ^ riderID ]
    driverID [ ^ driverID ]

    fare [ ^ 0 ]

    rideDetailsForDriver [
        ^ 'Ride ID: ', rideID printString,
           ' | Rider ID: ', riderID printString,
           ' | From: ', pickupLocation,
           ' To: ', dropoffLocation,
           ' | Distance: ', distance printString,
           ' miles | Fare: $', self fare printString.
    ]

    rideDetailsForRider [
        ^ 'Ride ID: ', rideID printString,
           ' | Driver ID: ', driverID printString,
           ' | From: ', pickupLocation,
           ' To: ', dropoffLocation,
           ' | Distance: ', distance printString,
           ' miles | Fare: $', self fare printString.
    ]
]

"----- StandardRide Subclass -----"
Ride subclass: StandardRide [
    fare [ ^ distance * 1.5 ]
]

"----- PremiumRide Subclass -----"
Ride subclass: PremiumRide [
    fare [ ^ distance * 3.0 ]
]

"----- Driver Class -----"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> newWithID: id name: n rating: r [
        ^ (self new)
            setID: id;
            setName: n;
            setRating: r;
            initializeRides;
            yourself.
    ]

    setID: id [ driverID := id. ]
    setName: n [ name := n. ]
    setRating: r [ rating := r. ]
    initializeRides [ assignedRides := OrderedCollection new. ]

    addRide: r [ assignedRides add: r. ]

    getDriverInfo [
        | info |
        info := '========== Driver Information ==========
'.
        info := info , 'Driver Name: ', name, '
'.
        info := info , 'Driver ID: ', driverID printString, '
'.
        info := info , 'Rating: ', rating printString, '
'.
        info := info , 'Total Rides Completed: ', assignedRides size printString, '
'.
        info := info , '
-- Completed Rides --
'.
        assignedRides do: [:r | info := info , r rideDetailsForDriver , '
' ].
        ^ info
    ]
]

"----- Rider Class -----"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> newWithID: id name: n [
        ^ (self new)
            setID: id;
            setName: n;
            initializeRides;
            yourself.
    ]

    setID: id [ riderID := id. ]
    setName: n [ name := n. ]
    initializeRides [ requestedRides := OrderedCollection new. ]

    requestRide: r [ requestedRides add: r. ]

    getRiderInfo [
        | info |
        info := '========== Rider Information ==========
'.
        info := info , 'Rider Name: ', name, '
'.
        info := info , 'Rider ID: ', riderID printString, '
'.
        info := info , 'Total Rides Requested: ', requestedRides size printString, '
'.
        info := info , '
-- Ride History --
'.
        requestedRides do: [:r | info := info , r rideDetailsForRider , '
' ].
        ^ info
    ]
]

"----- Test / Main Execution Block -----"
| ride1 ride2 driver rider |

ride1 := StandardRide newWithID: 101 pickup: 'DFW Airport' dropoff: 'Dallas Downtown' distance: 10 riderID: 100 driverID: 1.
ride2 := PremiumRide newWithID: 102 pickup: 'Galleria Mall' dropoff: 'Ft Worth Center' distance: 30 riderID: 100 driverID: 1.

driver := Driver newWithID: 1 name: 'Manus' rating: 4.
driver addRide: ride1.
driver addRide: ride2.

rider := Rider newWithID: 100 name: 'Nishan'.
rider requestRide: ride1.
rider requestRide: ride2.

"Display driver and rider info"
driver getDriverInfo displayNl.
rider getRiderInfo displayNl.
