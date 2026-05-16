#!/bin/bash

# ============================================================
#   ALAS A TU DESTINO - Instalador para macOS
#   Ejecutar UNA SOLA VEZ en la Mac nueva
# ============================================================

clear
echo ""
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   ALAS A TU DESTINO - Instalación Mac   ║"
echo "  ╚══════════════════════════════════════════╝"
echo ""

REPO_URL="https://github.com/ALAS-ATU/alas-destino.git"
INSTALL_DIR="$HOME/Desktop/alas-destino"

# ── 1. Xcode Command Line Tools (necesario para git) ────────
echo "  [1/4] Verificando herramientas del sistema..."
if ! command -v git &>/dev/null; then
  echo "  → Instalando Xcode Command Line Tools..."
  xcode-select --install
  echo ""
  echo "  ⚠️  PAUSA: Completá la instalación de Xcode que apareció"
  echo "  Luego volvé a ejecutar este script."
  read -p "  Presioná ENTER cuando hayas terminado..." _
fi
echo "  ✓ git disponible"

# ── 2. Homebrew ─────────────────────────────────────────────
echo ""
echo "  [2/4] Verificando Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "  → Instalando Homebrew (puede tardar unos minutos)..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Agregar brew al PATH para Apple Silicon
  if [[ $(uname -m) == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "  ✓ Homebrew ya instalado"
fi

# ── 3. Node.js ───────────────────────────────────────────────
echo ""
echo "  [3/4] Verificando Node.js..."
if ! command -v node &>/dev/null; then
  echo "  → Instalando Node.js..."
  brew install node
else
  NODE_VER=$(node -v)
  echo "  ✓ Node.js $NODE_VER ya instalado"
fi

# ── 4. Clonar o actualizar el proyecto ──────────────────────
echo ""
echo "  [4/4] Descargando proyecto desde GitHub..."
if [ -d "$INSTALL_DIR" ]; then
  echo "  → El proyecto ya existe, actualizando..."
  cd "$INSTALL_DIR"
  git pull origin main
else
  echo "  → Clonando repositorio..."
  git clone "$REPO_URL" "$INSTALL_DIR"
  cd "$INSTALL_DIR"
fi

echo ""
echo "  → Instalando dependencias npm (primera vez puede tardar)..."
npm install

# ── Crear acceso directo en el Escritorio ───────────────────
SHORTCUT="$HOME/Desktop/🚀 Iniciar ATD.command"
cat > "$SHORTCUT" << 'SCRIPT'
#!/bin/bash
clear
echo ""
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   ALAS A TU DESTINO - Iniciando...      ║"
echo "  ╚══════════════════════════════════════════╝"
echo ""
echo "  Sincronizando datos desde la nube..."
echo "  Abriendo en: http://localhost:3000"
echo "  Para detener: cerrar esta ventana"
echo ""

cd "$HOME/Desktop/alas-destino"

# Actualizar código automáticamente
git pull origin main --quiet 2>/dev/null && echo "  ✓ Código actualizado" || echo "  (sin cambios nuevos)"

npm start
SCRIPT

chmod +x "$SHORTCUT"

# ── Listo ────────────────────────────────────────────────────
echo ""
echo "  ╔══════════════════════════════════════════╗"
echo "  ║   ✅ INSTALACIÓN COMPLETA                ║"
echo "  ╚══════════════════════════════════════════╝"
echo ""
echo "  Para iniciar ATD:"
echo "  → Doble clic en '🚀 Iniciar ATD.command' en el Escritorio"
echo ""
echo "  La primera vez que abras el .command, Mac puede pedir"
echo "  permiso. Ir a: Sistema > Privacidad > Permitir."
echo ""
read -p "  ¿Querés iniciar el servidor ahora? (s/n): " respuesta
if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
  npm start
fi
