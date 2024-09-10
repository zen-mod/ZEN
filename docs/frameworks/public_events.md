# Public Events

This is a list of public CBA events executed by ZEN.

---

#### zen_curatorDisplayLoaded

Executed **locally** when the Zeus display is loaded.

**Parameters:**

- 0: Zeus Display &lt;DISPLAY&gt;

---

#### zen_curatorDisplayUnloaded

Executed **locally** when the Zeus display is unloaded.

**Parameters:**

- 0: Zeus Display &lt;DISPLAY&gt;

---

#### zen_remoteControlStarted

Executed **locally** when Zeus starts remote controlling a unit.

**Parameters:**

- 0: Unit &lt;OBJECT&gt;

---

#### zen_remoteControlStopped

Executed **locally** when Zeus stops remote controlling a unit.

**Parameters:**

- 0: Unit &lt;OBJECT&gt;

---

#### zen_editor_modeChanged

Executed **locally** when the Zeus display's create trees mode is changed.
Event still fires if the selected mode is the same as the previous mode.

**Parameters:**

- 0: Display &lt;DISPLAY&gt;
- 1: Mode &lt;NUMBER&gt;
- 2: Side &lt;NUMBER&gt;

---

#### zen_editor_sideChanged

Executed **locally** when the Zeus display's create trees side is changed.
Event still fires if the selected side is the same as the previous side.

**Parameters:**

- 0: Display &lt;DISPLAY&gt;
- 1: Mode &lt;NUMBER&gt;
- 2: Side &lt;NUMBER&gt;
