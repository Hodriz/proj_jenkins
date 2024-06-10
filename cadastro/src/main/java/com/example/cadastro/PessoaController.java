package com.example.cadastro;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class PessoaController {

    @Autowired
    private PessoaRepository pessoaRepository;

    @GetMapping("/pessoas")
    public String listarPessoas(Model model) {
        model.addAttribute("pessoas", pessoaRepository.findAll());
        return "lista_pessoas";
    }

    @GetMapping("/pessoas/nova")
    public String novaPessoaForm(Model model) {
        model.addAttribute("pessoa", new Pessoa());
        return "nova_pessoa";
    }

    @PostMapping("/pessoas")
    public String salvarPessoa(@ModelAttribute Pessoa pessoa) {
        pessoaRepository.save(pessoa);
        return "redirect:/pessoas";
    }

    @GetMapping ("/pessoas/{id}")
    public String excluirPessoa(@PathVariable("id") Long id, Model model){
        pessoaRepository.deleteById(id);
        return "redirect:/pessoas";
    }
}
