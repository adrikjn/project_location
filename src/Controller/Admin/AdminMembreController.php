<?php

namespace App\Controller\Admin;

use App\Entity\Membre;
use App\Form\AdminMembreType;
use App\Repository\MembreRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

#[Route('/admin/membre')]
class AdminMembreController extends AbstractController
{
    #[Route('/', name: 'app_admin_membre')]
    public function index(MembreRepository $repo, EntityManagerInterface $manager): Response
    {
        $colonnes = $manager->getClassMetadata(Membre::class)->getFieldNames();
        $mems = $repo->findAll();
        return $this->render('admin_membre/index.html.twig', [
            'mems' => $mems,
            'colonnes' => $colonnes
        ]);
    }

    
     #[Route("/new", name:"admin_crud_membres_new")]
     #[Route("/edit/{id}", name:"admin_crud_membres_edit")]
    public function form(Membre $membre = null, EntityManagerInterface $manager, Request $rq, UserPasswordHasherInterface $hasher)
    {
        if (!$membre) {
            $membre = new Membre;
            $membre->setDateEnregistrement(new \DateTime());
        }

        $form = $this->createForm(AdminMembreType::class, $membre);

        $form->handleRequest($rq);

        if ($form->isSubmitted() && $form->isValid()) {

            // si le membre est nouveau et le mdp est vide
            if(!$membre->getId() && $form->get('plainPassword')->getData() == null)
            {
                $this->addFlash('danger', "Un nouveau membre doit avoir un mot de passe.");
                return $this->redirectToRoute('admin_crud_membres_new');
                // je renvoie une erreur
            }

            // si c'est un nouvel utilisateur ou qu'on modifie le mot de passe d'un utilisateur existant
            if ($form->get('plainPassword')->getData()) {
                $membre->setPassword($hasher->hashPassword($membre, $form->get('plainPassword')->getData()));
                // alors on hash le nouveau mdp
            }

            $manager->persist($membre);
            $manager->flush();
            $this->addFlash("success", "Le membre a bien été enregistré !");
            return $this->redirectToRoute('app_admin_membre');
        }
        return $this->render('admin_membre/form.html.twig', [
            'form' => $form,
            'editMode' => $membre->getId() != NULL
        ]);
    }

     
     #[Route("/delete/{id}", name:"admin_crud_membres_delete")]
    public function delete(Membre $membre = null, EntityManagerInterface $manager)
    {
        if ($membre) {
            $manager->remove($membre);
            $manager->flush();
            $this->addFlash('success', 'Le membre a bien été supprimé !');
        }
        return $this->redirectToRoute('app_admin_membre');
    }
}
