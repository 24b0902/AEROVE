import React, { useEffect, useState } from 'react';
import './styles.css';

const announcements = [/* ← paste the array from aerove_js.js */];
const achievements = [/* ← paste the array from aerove_js.js */];
const teamMembers = [/* ← paste the array from aerove_js.js */];
const tasks = [/* ← paste the array from aerove_js.js */];

const formatDate = (date) => new Date(date).toLocaleDateString('en-US', {
  year: 'numeric',
  month: 'short',
  day: 'numeric'
});

const getInitials = (name) => name.split(' ').map(n => n[0]).join('');

const App = () => {
  const [currentPage, setCurrentPage] = useState('home');
  const [taskState, setTaskState] = useState(tasks);

  useEffect(() => {
    const typewriter = document.getElementById('typewriter');
    const text = 'Team AeRoVe';
    let i = 0;
    const type = () => {
      if (i < text.length) {
        typewriter.innerHTML += text.charAt(i);
        i++;
        setTimeout(type, 100);
      }
    };
    setTimeout(type, 500);
  }, []);

  const moveTask = (id, status) => {
    setTaskState(prev =>
      prev.map(task => task.id === id ? { ...task, status } : task)
    );
  };

  const renderTasks = (status) =>
    taskState
      .filter(task => task.status === status)
      .map(task => (
        <div key={task.id} className="task-item">
          <div className="task-title">{task.title}</div>
          <div className="task-assignee">Assigned to: {task.assignee}</div>
          <div className="task-due-date">Due: {formatDate(task.dueDate)}</div>
          <div className="task-controls">
            {status === 'todo' && (
              <button className="task-btn move-right" onClick={() => moveTask(task.id, 'progress')}>Start →</button>
            )}
            {status === 'progress' && (
              <>
                <button className="task-btn move-left" onClick={() => moveTask(task.id, 'todo')}>← To Do</button>
                <button className="task-btn move-right" onClick={() => moveTask(task.id, 'completed')}>Complete →</button>
              </>
            )}
            {status === 'completed' && (
              <button className="task-btn move-left" onClick={() => moveTask(task.id, 'progress')}>← In Progress</button>
            )}
          </div>
        </div>
      ));

  return (
    <>
      <nav className="navbar">
        <div className="nav-container">
          <div className="nav-brand">
            <div className="brand-icon"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLhVkLFEmJHiIFYlCl-BCKligXP_0rYiAJtQ&s" /></div>
            <span className="brand-text">UMIC IITB</span>
            <div className="brand-icon"><img src="https://www.cse.iitb.ac.in/gramdrishti/static/images/iitb.png" /></div>
          </div>
          <div className="nav-links">
            {['home', 'team', 'tasks'].map(p => (
              <button key={p} className={`nav-btn ${currentPage === p ? 'active' : ''}`} onClick={() => setCurrentPage(p)}>
                <span>{p === 'home' ? 'Home' : p === 'team' ? 'Meet the Team' : 'Tasks'}</span>
              </button>
            ))}
          </div>
        </div>
      </nav>

      <main className="main-content">
        {currentPage === 'home' && (
          <section id="home" className="page active">
            <div className="hero-section">
              <div className="container">
                <div className="hero-content">
                  <h1 id="typewriter" className="hero-title"></h1>
                  <p className="hero-subtitle">"A drone is often preferred for missions that are too 'dull, dirty, or dangerous' for manned aircraft." Team AeRoVe of UMIC is on a never-ending pursuit of developing an ultimate system of autonomous fixed-wing as well as multirotor aircraft.</p>
                </div>
                <div className="hero-images">
                  <div className="image-grid">
                    {[1,2,3,4,5].map((_, i) => (
                      <div key={i} className={`image-container ${i === 4 ? 'main-image' : ''}`}>
                        <img className="drone-image" src={`https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ${i+1}&s`} alt={`Drone ${i+1}`} />
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            <div className="container content-grid">
              <div className="card">
                <div className="card-header"><h2>📢 Recent Announcements</h2></div>
                <div className="card-content">
                  {announcements.map(a => (
                    <div className="announcement-item" key={a.id}>
                      <div className="announcement-date">{formatDate(a.date)}</div>
                      <div className="announcement-message">{a.message}</div>
                    </div>
                  ))}
                </div>
              </div>
              <div className="card">
                <div className="card-header"><h2>🏆 Team Achievements</h2></div>
                <div className="card-content">
                  {achievements.map(a => (
                    <div className="achievement-item" key={a.id}>
                      <div className="achievement-date">{formatDate(a.date)}</div>
                      <div className="achievement-message">{a.message}</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </section>
        )}

        {currentPage === 'team' && (
          <section id="team" className="page active">
            <div className="container">
              <div className="page-header">
                <h1>Meet Our Team</h1>
                <p>Talented individuals driving innovation and excellence</p>
              </div>
              <div className="team-grid">
                {teamMembers.map(m => (
                  <div key={m.id} className="team-card">
                    <div className="team-avatar">{getInitials(m.name)}</div>
                    <div className="team-name">{m.name}</div>
                    <div className="team-role">{m.role} - {m.subsystem}</div>
                    <div className="team-fact">"{m.fact}"</div>
                    <div className="team-links">
                      <a href={m.github} className="team-link" target="_blank" rel="noreferrer">GH</a>
                      <a href={m.linkedin} className="team-link" target="_blank" rel="noreferrer">LI</a>
                      <a href={m.instagram} className="team-link" target="_blank" rel="noreferrer">IG</a>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {currentPage === 'tasks' && (
          <section id="tasks" className="page active">
            <div className="container">
              <div className="page-header">
                <h1>Task Board</h1>
                <p>Track progress and manage project workflows</p>
              </div>
              <div className="task-board">
                {['todo', 'progress', 'completed'].map(col => (
                  <div key={col} className="task-column">
                    <div className="column-header">
                      <h3>{col === 'todo' ? 'To Do' : col === 'progress' ? 'In Progress' : 'Completed'}</h3>
                      <span className="task-count">{taskState.filter(t => t.status === col).length}</span>
                    </div>
                    <div className="tasks-list">{renderTasks(col)}</div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}
      </main>
    </>
  );
};

export default App;
