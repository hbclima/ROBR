# ROBR — Assets MVP Checklist

## 🎨 Asset: Boto Cor-de-Roba (Forma Humana)

 Arquivo | Tipo | Tamanho | Status
---|---|---|---
`Boto.blend` | Blender 4.0.2 | 2.8 MB | ✅ Pronto
`Boto.obj` | Wavefront OBJ | 1.5 MB | ✅ Pronto
`Boto.mtl` | Material Library | 6 KB | ✅ Pronto
`Boto_thumb.png` | PNG 1024x1024 | 840 KB | ✅ Pronto

### Especificações

| Propriedade | Detalhe |
|---|---|
| **Estilo** | Low poly / Stylized |
| **Escala** | RO-like (cabeça 1/4 do corpo) |
| **Elemento** | Água |
| **Rig** | 18 bones (Root → Hips → Spine → Chest → Neck → Head + Braços + Pernas) |
| **Polígonos** | ~2.500 triângulos (low poly) |
| **Materiais** | 12 (pele, roupa branca, chapéu, cinto, espiráculo, etc.) |
| **Animação** | Rig completo pronto para walk/idle/attack |

### Como usar

```bash
# Abrir no Blender
blender Assets/Boto/Boto.blend

# Exportar para Roblox (como MeshPart):
# 1. Selecionar mesh → Exportar como OBJ
# 2. Importar no Roblox Studio via MeshImporter

# Exportar para Godot/Unity:
# Importar .blend diretamente (suporta nativamente)
```

### Próximos passos

- [ ] Criar mesh da forma animal (golfinho)
- [ ] Adicionar animações (idle, walk, attack, sedução)
- [ ] Criar variação de cor (rosa mais intenso na forma animal)
- [ ] Fazer LOD (Level of Detail) para Roblox

---

## 📦 Próximos Assets

# Nome do Asset | Tipo | Prioridade | Status
# Saci Pererê | Humanoid | Alta | Pendente
# Curupira | Humanoid | Alta | Pendente
# Boitatá | Serpente | Média | Pendente
# Cobra-d'Água | Serpente | Média | Pendente
# Mãe-da-Mata | Humanoid | Média | Pendente
# Sapo Cururu | Creature | Baixa | Pendente

---

*Atualizado: 2026-06-15 — Primeiro asset 3D gerado com Blender 4.0.2*
