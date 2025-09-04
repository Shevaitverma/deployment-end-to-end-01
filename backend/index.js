import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(express.json());
app.use(cors({ origin: process.env.CORS_ORIGIN, credentials: true }));

// --- DB ---
const db = await mongoose.connect(process.env.MONGODB_URI, {
  dbName: "todos"
});

console.log("Connected to MongoDB");

// --- Model ---
const todoSchema = new mongoose.Schema(
  {
    title: { type: String, required: true, trim: true },
    completed: { type: Boolean, default: false }
  },
  { timestamps: true }
);
const Todo = mongoose.model("Todo", todoSchema);

// --- Routes ---
app.get("/api/todos", async (_req, res) => {
  const items = await Todo.find().sort({ createdAt: -1 });
  res.json(items);
});

app.post("/api/todos", async (req, res) => {
  const { title } = req.body || {};
  if (!title?.trim()) return res.status(400).json({ error: "title required" });
  const todo = await Todo.create({ title: title.trim() });
  res.status(201).json(todo);
});

app.patch("/api/todos/:id", async (req, res) => {
  const { id } = req.params;
  const { title, completed } = req.body || {};
  const updated = await Todo.findByIdAndUpdate(
    id,
    { ...(title !== undefined && { title }), ...(completed !== undefined && { completed }) },
    { new: true }
  );
  if (!updated) return res.status(404).json({ error: "not found" });
  res.json(updated);
});

app.delete("/api/todos/:id", async (req, res) => {
  const { id } = req.params;
  const ok = await Todo.findByIdAndDelete(id);
  if (!ok) return res.status(404).json({ error: "not found" });
  res.status(204).end();
});

app.get("/health", (_req, res) => res.json({ ok: true }));

app.listen(process.env.PORT, () =>
  console.log(`API on http://localhost:${process.env.PORT}`)
);
