<?php

namespace App\Controller\Admin;

use App\Entity\Commande;
use App\Form\AdminCommandeType;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
#[Route('/admin/commande')]
class AdminCommandeController extends AbstractController
{
    #[Route('/', name: 'app_admin_commande')]
    public function index(CommandeRepository $repo, EntityManagerInterface $manager): Response
    {
        $colonnes = $manager->getClassMetadata(Commande::class)->getFieldNames();
        $coms = $repo->findAll();
        return $this->render('admin_commande/index.html.twig', [
            'coms' => $coms,
            'colonnes' => $colonnes
        ]);
    }
    
    
    // #[Route("/admin/crud/commandes/new", name:"admin_crud_commandes_new")]  (pas de route new pour les commandes)
    #[Route("/admin/crud/commandes/edit/{id}", name:"admin_crud_commandes_edit")]
    public function form(Commande $commande = null, EntityManagerInterface $manager, Request $rq)
    {
        if (!$commande) {
            $commande = new Commande;
            $commande->setDateEnregistrement(new \DateTime());
        }
        $form = $this->createForm(AdminCommandeType::class, $commande);

        $form->handleRequest($rq);

        if ($form->isSubmitted() && $form->isValid()) {
            $depart = $commande->getDateHeureDepart();

            if ($depart->diff($commande->getDateHeureFin())->invert == 1) {
                $this->addFlash('danger', 'Une période de temps ne peut pas être négative.');
                if ($commande->getId())
                    return $this->redirectToRoute('admin_crud_commandes_edit', [
                        'id' => $commande->getId()
                    ]);
                else
                    return $this->redirectToRoute('app_admin_commande');
            }
            // cette condition vérifie que les dates réservées sont correctes

            $days = $depart->diff($commande->getDateHeureFin())->days;
            $prixTotal = ($commande->getVehicule()->getPrixJournalier() * $days) + $commande->getVehicule()->getPrixJournalier();
            // récupère le prix total (sans la dernière addition, il manque un jour à payer)

            $commande->setPrixTotal($prixTotal);

            $manager->persist($commande);
            $manager->flush();
            $this->addFlash('success', 'La commande a bien été modifiée !');
            return $this->redirectToRoute('app_admin_commande');
        }
        return $this->render('admin_commande/form.html.twig', [
            'form' => $form,
            'editMode' => $commande->getId() != NULL
        ]);
    }

    
    #[Route("/delete/{id}", name:"admin_crud_commandes_delete")]
    public function delete(Commande $commande = null, EntityManagerInterface $manager)
    {
        if ($commande) {
            $manager->remove($commande);
            $manager->flush();
            $this->addFlash('success', 'La commande a bien été supprimée !');
        }
        return $this->redirectToRoute('app_admin_commande');
    }
}
