import fs from 'fs';
import path from 'path';

const APP_DIR = path.join(process.cwd(), 'app');
const fileName = 'auto_path.ts';

function scan(dir) {
  const files = fs.readdirSync(dir);
  
  if (files.includes('page.tsx') || files.includes('page.js')) {
    // Pfad relativ zum app-Ordner berechnen
    let routePath = '/' + path.relative(APP_DIR, dir).replace(/\\/g, '/');
    
    // Route Groups (Ordner in Klammern) entfernen
    routePath = routePath.replace(/\/\([^)]+\)/g, '') || '/';
    // Falls am Ende ein / steht (außer bei Root), entfernen
    if (routePath.length > 1 && routePath.endsWith('/')) routePath = routePath.slice(0, -1);

    const content = `export const path = "${routePath}";\n`;
    const filePath = path.join(dir, fileName);
    fs.writeFileSync(filePath, content);
    console.log(`✅ Generated path.ts for: ${routePath}`);
    // console.log(`NOT YET: Generated path.ts for: ${routePath}`, 'in', filePath);
  }

  // Rekursiv in Unterordner (außer _lib, (..), [..] falls gewünscht)
  files.forEach(file => {
    const fullPath = path.join(dir, file);
    if (fs.statSync(fullPath).isDirectory() && !file.startsWith('_') && !file.startsWith('[')) {
      scan(fullPath);
    }
  });
}

scan(APP_DIR);
