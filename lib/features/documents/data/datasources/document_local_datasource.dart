/// Data Datasource: DocumentLocalDataSource (In-Memory / Persistent Cache).
library;

import 'package:ai_hustle_copilot/features/documents/data/dtos/document_dtos.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';

/// Local data source managing cached documents, preset templates, and version history snapshots.
final class DocumentLocalDataSource {
  /// Creates a [DocumentLocalDataSource].
  DocumentLocalDataSource() {
    _seedMockData();
  }

  final Map<String, DocumentDto> _documents = {};
  final Map<String, List<DocumentVersion>> _versions = {};

  /// Retrieves cached documents, optionally filtered by project ID.
  Future<List<DocumentDto>> getDocuments({String? projectId}) async {
    final list = _documents.values.toList();
    if (projectId != null && projectId.isNotEmpty) {
      return list.where((d) => d.projectId == projectId).toList();
    }
    return list;
  }

  /// Retrieves single document by ID.
  Future<DocumentDto?> getDocumentById(String id) async {
    return _documents[id];
  }

  /// Saves or updates document DTO.
  Future<DocumentDto> saveDocument(DocumentDto doc) async {
    _documents[doc.id] = doc;
    return doc;
  }

  /// Deletes document by ID.
  Future<void> deleteDocument(String id) async {
    _documents.remove(id);
    _versions.remove(id);
  }

  /// Fetches version snapshots.
  Future<List<DocumentVersion>> getVersions(String documentId) async {
    return _versions[documentId] ?? [];
  }

  /// Adds a version snapshot.
  Future<DocumentVersion> createVersionSnapshot(DocumentVersion version) async {
    final versionList = _versions.putIfAbsent(version.documentId, () => []);
    // ignore: cascade_invocations
    versionList.insert(0, version);
    return version;
  }

  /// Returns preset templates gallery.
  Future<List<DocumentTemplate>> getTemplates() async {
    return _seedTemplates;
  }

  void _seedMockData() {
    final doc1 = DocumentDto(
      id: 'doc_101',
      projectId: 'proj_1',
      title: 'AI Co-Pilot Enterprise SaaS Architecture Specification',
      emojiIcon: '📄',
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      createdByUserId: 'usr_current',
      currentVersionNumber: 3,
      metadata: const {'author': 'Principal Software Architect'},
      blocks: const [
        DocumentBlockDto(
          id: 'doc_101_b0',
          documentId: 'doc_101',
          type: 'heading1',
          textContent: 'AI Hustle Co-Pilot — System Architecture',
          attributes: {},
          sortOrder: 0,
        ),
        DocumentBlockDto(
          id: 'doc_101_b1',
          documentId: 'doc_101',
          type: 'paragraph',
          textContent:
              'This document outlines the end-to-end Clean Architecture blueprint for our enterprise Flutter SaaS application across iOS and Android.',
          attributes: {},
          sortOrder: 1,
        ),
        DocumentBlockDto(
          id: 'doc_101_b2',
          documentId: 'doc_101',
          type: 'heading2',
          textContent: 'Core Technical Requirements',
          attributes: {},
          sortOrder: 2,
        ),
        DocumentBlockDto(
          id: 'doc_101_b3',
          documentId: 'doc_101',
          type: 'bulletList',
          textContent: 'Feature-First Clean Architecture pattern with Riverpod state management.',
          attributes: {},
          sortOrder: 3,
        ),
        DocumentBlockDto(
          id: 'doc_101_b4',
          documentId: 'doc_101',
          type: 'bulletList',
          textContent: 'Immutable block-based editor engine with streaming AI token updates.',
          attributes: {},
          sortOrder: 4,
        ),
        DocumentBlockDto(
          id: 'doc_101_b5',
          documentId: 'doc_101',
          type: 'callout',
          textContent: '💡 AI generation incorporates project memory and knowledge RAG context automatically.',
          attributes: {},
          sortOrder: 5,
        ),
      ],
    );

    final doc2 = DocumentDto(
      id: 'doc_102',
      projectId: 'proj_1',
      title: 'Q3 Enterprise Product Roadmap & Strategy',
      emojiIcon: '🚀',
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
      createdByUserId: 'usr_current',
      currentVersionNumber: 1,
      metadata: const {},
      blocks: const [
        DocumentBlockDto(
          id: 'doc_102_b0',
          documentId: 'doc_102',
          type: 'heading1',
          textContent: 'Q3 Growth & Product Expansion',
          attributes: {},
          sortOrder: 0,
        ),
        DocumentBlockDto(
          id: 'doc_102_b1',
          documentId: 'doc_102',
          type: 'paragraph',
          textContent:
              'Strategic plan focusing on document intelligence, autonomous agents, and team workspace capabilities.',
          attributes: {},
          sortOrder: 1,
        ),
      ],
    );

    _documents[doc1.id] = doc1;
    _documents[doc2.id] = doc2;
  }

  static const List<DocumentTemplate> _seedTemplates = [
    DocumentTemplate(
      id: 'tpl_biz_plan',
      name: 'Business Plan',
      category: 'Business',
      description: 'Comprehensive business proposal with executive summary, market analysis, and revenue models.',
      iconName: '💼',
      aiSystemPrompt: 'You are an executive business analyst. Generate structured, professional business strategies.',
      defaultBlocks: [
        DocumentBlock(id: 'tb_0', documentId: '', type: BlockType.heading1, textContent: 'Executive Summary', sortOrder: 0),
        DocumentBlock(id: 'tb_1', documentId: '', type: BlockType.paragraph, textContent: 'Overview of company vision, target market, and value proposition.', sortOrder: 1),
        DocumentBlock(id: 'tb_2', documentId: '', type: BlockType.heading2, textContent: 'Market Opportunity & Competition', sortOrder: 2),
        DocumentBlock(id: 'tb_3', documentId: '', type: BlockType.bulletList, textContent: 'Target Demographic: Enterprise SaaS & Remote Teams.', sortOrder: 3),
        DocumentBlock(id: 'tb_4', documentId: '', type: BlockType.heading2, textContent: 'Financial Strategy', sortOrder: 4),
      ],
    ),
    DocumentTemplate(
      id: 'tpl_proposal',
      name: 'Client Project Proposal',
      category: 'Sales',
      description: 'High-converting project proposal featuring problem statement, scope of work, timeline, and pricing.',
      iconName: '📄',
      aiSystemPrompt: 'You are a senior sales director crafting persuasive enterprise proposals.',
      defaultBlocks: [
        DocumentBlock(id: 'tp_0', documentId: '', type: BlockType.heading1, textContent: 'Project Proposal: Solution Overview', sortOrder: 0),
        DocumentBlock(id: 'tp_1', documentId: '', type: BlockType.paragraph, textContent: 'Detailed breakdown of deliverables, milestones, and success metrics.', sortOrder: 1),
        DocumentBlock(id: 'tp_2', documentId: '', type: BlockType.heading2, textContent: 'Scope of Work & Deliverables', sortOrder: 2),
      ],
    ),
    DocumentTemplate(
      id: 'tpl_resume',
      name: 'Executive Resume',
      category: 'Career',
      description: 'Modern, impact-focused resume template tailored for senior leadership and technical roles.',
      iconName: '👤',
      aiSystemPrompt: 'You are an executive career coach formatting impact-driven accomplishment bullet points.',
      defaultBlocks: [
        DocumentBlock(id: 'tr_0', documentId: '', type: BlockType.heading1, textContent: 'Alex Morgan — Senior Engineering Director', sortOrder: 0),
        DocumentBlock(id: 'tr_1', documentId: '', type: BlockType.paragraph, textContent: 'Results-driven software architect with 10+ years scaling cloud platforms.', sortOrder: 1),
        DocumentBlock(id: 'tr_2', documentId: '', type: BlockType.heading2, textContent: 'Core Competencies', sortOrder: 2),
      ],
    ),
    DocumentTemplate(
      id: 'tpl_cover_letter',
      name: 'Cover Letter',
      category: 'Career',
      description: 'Persuasive application cover letter emphasizing strategic cultural fit and technical achievements.',
      iconName: '✉️',
      aiSystemPrompt: 'You are an executive recruiter drafting compelling cover letters.',
      defaultBlocks: [
        DocumentBlock(id: 'tc_0', documentId: '', type: BlockType.heading1, textContent: 'Application for Lead Systems Architect', sortOrder: 0),
        DocumentBlock(id: 'tc_1', documentId: '', type: BlockType.paragraph, textContent: 'Dear Hiring Committee,', sortOrder: 1),
      ],
    ),
    DocumentTemplate(
      id: 'tpl_tech_spec',
      name: 'Technical Specification',
      category: 'Engineering',
      description: 'Detailed software design document featuring architecture diagrams, API contracts, and data models.',
      iconName: '⚙️',
      aiSystemPrompt: 'You are a principal software architect generating RFC-style technical specs.',
      defaultBlocks: [
        DocumentBlock(id: 'tt_0', documentId: '', type: BlockType.heading1, textContent: 'Technical Architecture Specification', sortOrder: 0),
        DocumentBlock(id: 'tt_1', documentId: '', type: BlockType.paragraph, textContent: 'System design, domain entities, and data persistence contracts.', sortOrder: 1),
        DocumentBlock(id: 'tt_2', documentId: '', type: BlockType.heading2, textContent: 'Domain Data Flow', sortOrder: 2),
      ],
    ),
    DocumentTemplate(
      id: 'tpl_marketing_strat',
      name: 'Marketing Strategy',
      category: 'Marketing',
      description: 'Go-to-market plan covering customer personas, distribution channels, and campaign metrics.',
      iconName: '📈',
      aiSystemPrompt: 'You are a Chief Marketing Officer detailing multi-channel GTM campaigns.',
      defaultBlocks: [
        DocumentBlock(id: 'tm_0', documentId: '', type: BlockType.heading1, textContent: 'Go-To-Market & Growth Strategy', sortOrder: 0),
        DocumentBlock(id: 'tm_1', documentId: '', type: BlockType.paragraph, textContent: 'Omnichannel customer acquisition strategy and positioning.', sortOrder: 1),
      ],
    ),
  ];
}
