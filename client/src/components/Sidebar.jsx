import React from "react";
import { NavLink, useLocation, useNavigate } from "react-router-dom"; 
import { useRole } from "../contexts/RoleContext";

const allNavItems = {
  public: [
    { path: "/public", label: "Public Calendar" },
    { path: "/student", label: "Student Dashboard" },
      // { path: "/registration", label: "Register for Event" },
    { path: "/speakers", label: "About Performers" }
  ],
  eventManager: [
    { path: "/event-manager", label: "Event Manager Dash" },
    { path: "/manager/create", label: "Create Event" },
    { path: "/venues", label: "Venue Inventory" },
    { path: "/speakers", label: "Speaker Bios" },
    { path: "/crm", label: "CRM" },
    { path: "/resources", label: "Resource Management" },
    { path: "/reports", label: "Reports" },
    { path: "/breakout-sessions", label: "Breakout Sessions" },
    { path: "/mobile-app", label: "Mobile App" },
      { path: "/accessibility-demo", label: "Accessibility" },
  ],
  admin: [
    { path: "/admin", label: "Admin Dashboard" },
    { path: "/admin/requests", label: "Review Requests" },
    { path: "/contracts", label: "Contract Generator" },
    { path: "/invoices", label: "Invoices" },
    { path: "/speakers", label: "Speaker Bios" },
    { path: "/crm", label: "CRM" },
    { path: "/resources", label: "Resource Management" },
    { path: "/reports", label: "Reports" },
    { path: "/accessibility-demo", label: "Accessibility" },
    { path: "/venues", label: "Venue Inventory" },
    { path: "/breakout-sessions", label: "Breakout Sessions" },
    { path: "/mobile-app", label: "Mobile App" },
    { path: "/security-settings", label: "Security Settings" },
    { path: "/data-migration", label: "Data Migration" },
    { path: "/compliance", label: "Compliance" },
  ],
  default: [
    { path: "/login", label: "Login" },
    { path: "/public", label: "Public Calendar" },
  ],
};

export default function Sidebar() {
  const { role, setRole } = useRole();
  const location = useLocation();
  const navigate = useNavigate();
  const navItems = allNavItems[role] || allNavItems.default;

  return (
    <aside className="w-64 bg-gradient-to-b from-blue-900 to-gray-900 text-white min-h-screen flex flex-col justify-between p-6 shadow-xl">
      <div>
        {/* Logo/Brand */}
        {/* <div className="flex items-center gap-2 mb-8">
          <h2 className="text-2xl font-bold tracking-wide text-blue-300">Event & Venue Management Software Prototype</h2>
        </div> */}


        {/* <div className="px-3 py-4">
  <div className="text-sm font-semibold uppercase tracking-widest text-blue-200/90">
    EVMS
  </div>
  <div className="text-xl font-extrabold bg-gradient-to-r from-sky-300 to-indigo-300 
                  bg-clip-text text-transparent leading-tight">
    Event & Venue
  </div>
  <div className="text-blue-100 -mt-0.5">Management</div>
  <span className="mt-1 inline-block rounded-full bg-white/10 px-2 py-0.5 
                   text-[10px] font-bold text-blue-50 ring-1 ring-white/20">
    Prototype
  </span>
</div> */}
{/* Sidebar brand / logo */}
{/* Rexus Logo */}
            <div className="flex items-center justify-center">
              <img src="./rexus_logo.png" width = "125" alt='Rexus Logo' ></img>
            </div>
<div className="flex items-center gap-3 px-3 pt-3 pb-6 select-none">
  
          <div className="flex items-center gap-2 justify-center select-none pl-4">
            {/* Wordmark */}
            <div className="leading-tight text-left justify-center">
              <div className="text-white-800 font-extrabold text-[20px] tracking-tight">
                Campus Connect
              </div>
              <div className="text-gray-600 text-center text-[14px] font-semibold -mt-0.5 pt-2">
                <span className="ml-2 align-middle rounded-full px-2.5 py-0.5 
                                text-[12px] font-bold text-blue-700 
                                bg-blue-50 ring-1 ring-blue-200 ">
                  Prototype
                </span>
              </div>
            </div>
  </div>
</div>

        <nav className="space-y-2">
          {navItems.map(({ path, label }) => {
            const isActive =
              location.pathname === path ||
              location.pathname.startsWith(path + "#");
            return (
              <NavLink
                key={path}
                to={path}
                className={`flex items-center px-4 py-3 rounded-lg font-medium transition-all duration-200 ${
                  isActive
                    ? "bg-gradient-to-r from-blue-600 to-blue-500 text-white shadow-md"
                    : "text-gray-300 hover:bg-gray-800 hover:text-white"
                }`}
              >
                <span className="truncate">{label}</span>
              </NavLink>
            );
          })}
        </nav>
      </div>

      {/* Logout */}
      <button
        onClick={() => {
          setRole(null);
          navigate("/login");
        }}
        className="w-full bg-red-600 text-white py-2 rounded-md font-semibold hover:bg-red-700 transition"
      >
        Log Out
      </button>
    </aside>
  );
}
