/// TGMS_Tweener_Create()

// Global system-wide settings
minDeltaFPS = 10;         // Minimum frame rate before delta time will lag behind
autoCleanIterations = 10; // Number of tweens to check each step for auto-cleaning

// System maintenance variables
autoCleanIndex = 0;                  // Used for processing step tweens' passive memory manager
keepPersistent = false;              // Becomes true if tweening used in persistent room
maxDelta = 1/minDeltaFPS;            // Cache delta cap
deltaTime = delta_time/1000000;      // Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;           // Holds delta time from previous step
deltaRestored = false;               // Used to help maintain predictable delta timing
deltaSelect[0] = 1;                  // Store time scale in time scales array for step/delta selection
deltaSelect[1] = deltaTime;          // Store delta time scale in time scales array for step/delta selection    

// Required data structures
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
simpleTweens = ds_map_create();      // Used for simple tweens
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events

