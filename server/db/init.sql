-- =========================================
-- EVMS Database Schema (Minimal Routes Only)
-- Supports: users(auth), colleges, venues,
-- events, registrations
-- =========================================

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- now plain text
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'student'
        CHECK (role IN ('admin', 'eventManager', 'student')),
    college_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Colleges table
CREATE TABLE IF NOT EXISTS colleges (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Venues table
CREATE TABLE IF NOT EXISTS venues (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capacity INTEGER,
    description TEXT,
    location VARCHAR(255),
    amenities TEXT[],
    hourly_rate DECIMAL(10,2),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Events table
CREATE TABLE IF NOT EXISTS events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    college_id INTEGER REFERENCES colleges(id),
    venue_id INTEGER REFERENCES venues(id),
    date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    max_capacity INTEGER,
    status VARCHAR(50) DEFAULT 'Pending'
        CHECK (status IN ('Pending', 'Approved', 'Rejected', 'Tentative')),
    requester_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Registrations table
CREATE TABLE IF NOT EXISTS registrations (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES events(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    dietary_restrictions TEXT,
    special_accommodations TEXT,
    status VARCHAR(50) DEFAULT 'confirmed'
        CHECK (status IN ('confirmed', 'cancelled', 'waitlist')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- Seed Data
-- =========================================

-- Colleges
INSERT INTO colleges (name) VALUES 
    ('Houston Community College'),
    ('San Jacinto College'),
    ('Lone Star College - North Harris'),
    ('Lone Star College - CyFair'),
    ('Lone Star College - Kingwood'),
    ('Lone Star College - Tomball'),
    ('Lee College'),
    ('College of the Mainland'),
    ('Alvin Community College'),
    ('Wharton County Junior College'),
    ('Blinn College - Bryan Campus'),
    ('Texas State Technical College - Fort Bend'),
    ('Galveston College'),
    ('Brazosport College'),
    ('The College of Health Care Professions'),
    ('Commonwealth Institute of Funeral Service'),
    ('Fortis College'),
    ('Pima Medical Institute - Houston'),
    ('Universal Technical Institute of Texas'),
    ('Center for Advanced Legal Studies'),
    ('School of Automotive Machinists & Technology'),
    ('Culinary Institute Lenotre'),
    ('North American University'),
    ('Houston Graduate School of Theology')
ON CONFLICT DO NOTHING;

-- Venues
INSERT INTO venues (name, capacity, description, location) VALUES 
    ('TSTC Conference Center', 500, 'State-of-the-art conference facility with multiple breakout rooms', 'Richmond Main Campus'),
    ('TSTC Auditorium', 300, 'Professional theater space for performances and presentations', 'TSTC Arts Complex'),
    ('TSTC Executive Boardroom', 50, 'Executive meeting room with advanced AV equipment', 'TSTC Administration Building'),
    ('TSTC Outdoor Pavilion', 1000, 'Open-air venue for large events and ceremonies', 'TSTC Campus Green'),
    ('TSTC Technology Lab', 200, 'Modern computer lab for technology demonstrations', 'TSTC Technology Center'),
    ('TSTC Student Center', 400, 'Multi-purpose student center for events and activities', 'TSTC Student Life Building'),
    ('TSTC Innovation Hub', 150, 'Collaborative space for innovation and entrepreneurship', 'TSTC Innovation Center'),
    ('TSTC Healthcare Simulation Lab', 100, 'Advanced healthcare training facility', 'TSTC Health Sciences Building'),
    ('TSTC Business Incubator', 75, 'Space for business development and networking', 'TSTC Business Center'),
    ('TSTC Cultural Arts Center', 600, 'Dedicated space for cultural events and performances', 'TSTC Arts District')
ON CONFLICT DO NOTHING;

-- Admin User
INSERT INTO users (email, password, name, role)
VALUES ('admin@TSTC.edu', 'admin123', 'TSTC System Administrator', 'admin')
ON CONFLICT (email) DO NOTHING;

-- Event Manager User
INSERT INTO users (email, password, name, role)
VALUES ('manager@TSTC.edu', 'manager123', 'Event Manager User', 'eventManager')
ON CONFLICT (email) DO NOTHING;

-- Student / Public User
INSERT INTO users (email, password, name, role)
VALUES ('student@TSTC.edu', 'student123', 'Student Public User', 'student')
ON CONFLICT (email) DO NOTHING;


-- Demo Events
INSERT INTO events (title, description, college_id, venue_id, date, start_time, end_time, max_capacity, status, requester_id) VALUES 
    ('TSTC Fall Open House', 'Annual open house showcasing all TSTC colleges and programs. Meet faculty, tour facilities, and learn about financial aid opportunities.', 1, 1, '2025-09-15', '10:00:00', '16:00:00', 500, 'Approved', 1),
    ('TSTC Leadership Summit', 'Professional development conference for TSTC faculty and staff. Workshops on leadership, innovation, and student success.', 4, 3, '2025-10-05', '08:30:00', '17:00:00', 100, 'Approved', 1),
    ('TSTC Student Success Conference', 'Conference focused on student retention, academic success, and career preparation across all TSTC institutions.', 2, 2, '2025-11-12', '09:00:00', '15:00:00', 300, 'Approved', 1),
    ('TSTC Technology Innovation Expo', 'Showcase of cutting-edge technology initiatives and digital learning tools across TSTC colleges.', 3, 5, '2025-10-22', '10:00:00', '18:00:00', 200, 'Approved', 1),
    ('TSTC Arts & Culture Festival', 'Celebration of artistic and cultural diversity across TSTC institutions. Performances, exhibits, and workshops.', 5, 4, '2025-11-08', '12:00:00', '20:00:00', 800, 'Approved', 1),
    ('TSTC Healthcare Career Fair', 'Career fair connecting students with healthcare employers and educational opportunities.', 2, 1, '2025-09-28', '09:00:00', '16:00:00', 400, 'Approved', 1),
    ('TSTC Business & Entrepreneurship Forum', 'Forum for business students and entrepreneurs to network with industry leaders and learn about opportunities.', 4, 3, '2025-10-15', '13:00:00', '18:00:00', 150, 'Approved', 1),
    ('TSTC Community Service Day', 'Day of service bringing together TSTC students, faculty, and staff to serve local communities.', 1, 4, '2025-09-20', '08:00:00', '14:00:00', 600, 'Approved', 1),
    ('TSTC Research Symposium', 'Annual symposium showcasing student and faculty research across all TSTC colleges.', 2, 5, '2025-11-05', '09:00:00', '17:00:00', 250, 'Approved', 1),
    ('TSTC Winter Graduation Ceremony', 'Celebration of student achievements and graduation ceremonies across TSTC institutions.', 1, 1, '2025-12-12', '14:00:00', '18:00:00', 1000, 'Approved', 1)
ON CONFLICT DO NOTHING;

-- Demo Registration
INSERT INTO registrations (event_id, user_id, name, email, phone, status)
VALUES
    (1, 1, 'Admin User', 'admin@TSTC.edu', '555-123-4567', 'confirmed')
ON CONFLICT DO NOTHING;


-- =========================================
-- Optimizations & Integrity
-- =========================================
ALTER TABLE colleges ADD CONSTRAINT colleges_name_uniq UNIQUE (name);
ALTER TABLE venues   ADD CONSTRAINT venues_name_uniq   UNIQUE (name);

CREATE INDEX idx_events_date        ON events(date);
CREATE INDEX idx_events_venue_id    ON events(venue_id);
CREATE INDEX idx_events_college_id  ON events(college_id);
CREATE INDEX idx_regs_event_id      ON registrations(event_id);