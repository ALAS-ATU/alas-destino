# 🍎 Instalar ATD en MacBook Air

## Qué necesitás saber antes de empezar

- Esta Mac va a funcionar como **terminal cliente**
- Todos los datos se sincronizan con **Supabase** (la nube)
- El código está en **GitHub** — siempre se descarga la última versión
- No necesitás copiar nada de la PC, todo baja automático

---

## Instalación (una sola vez)

### Paso 1 — Copiar el instalador a la Mac

Tenés dos opciones:

**Opción A — Desde un pendrive:**
Copiar el archivo `instalar-mac.sh` al Escritorio de la Mac

**Opción B — Desde internet (más fácil):**
Abrir Terminal en la Mac y pegar esto:
```bash
curl -o ~/Desktop/instalar-mac.sh https://raw.githubusercontent.com/ALAS-ATU/alas-destino/main/instalar-mac.sh && chmod +x ~/Desktop/instalar-mac.sh && ~/Desktop/instalar-mac.sh
```

### Paso 2 — Ejecutar el instalador

1. Abrir **Terminal** (buscarlo en Spotlight con ⌘+Espacio, escribir "Terminal")
2. Escribir:
   ```bash
   bash ~/Desktop/instalar-mac.sh
   ```
3. Seguir las instrucciones en pantalla
4. La instalación tarda ~5 minutos la primera vez

---

## Uso diario

Una vez instalado:

1. **Doble clic** en `🚀 Iniciar ATD.command` en el Escritorio
2. Se abre Terminal y el navegador en `http://localhost:3000`
3. Ir a **☁️ Sincronizar** en la app para traer los datos de la nube

> ⚠️ La primera vez que abras el `.command`, Mac puede bloquearlo.
> Ir a: **Ajustes del Sistema → Privacidad y Seguridad → Permitir**

---

## Flujo de trabajo entre las dos máquinas

```
PC Windows (servidor principal)
    │
    ├── Hace cambios → ☁️ Sincronizar → Supabase
    │
MacBook Air (terminal cliente)
    │
    └── Abre app → ☁️ Sincronizar → Trae datos de Supabase
```

**Regla simple:** Antes de trabajar, presionar ☁️ Sincronizar.
Al terminar, presionar ☁️ Sincronizar de nuevo.

---

## Si hay una actualización del código

El script de inicio (`🚀 Iniciar ATD.command`) hace `git pull` automático
cada vez que lo abrís, así siempre tenés la última versión.

---

## Problemas comunes

| Problema | Solución |
|----------|----------|
| "No se puede abrir porque es de desarrollador desconocido" | Ajustes → Privacidad → Permitir |
| Puerto 3000 en uso | Cerrar otras ventanas de Terminal y volver a intentar |
| Datos desactualizados | Presionar ☁️ Sincronizar en la app |
| `command not found: npm` | Volver a correr `instalar-mac.sh` |
